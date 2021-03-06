import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidspend3/main.dart';
import 'package:kidspend3/menu_and_scene_data/menu_record.dart';
import 'package:kidspend3/primary_list_page/disappearing_space_bar_title.dart';

class ZoomScaffold extends StatefulWidget {
  final MenuItem currentMenuItem;
  final ZoomScaffoldBuilder menuScreenBuilder;

  ZoomScaffold({
    this.currentMenuItem,
    this.menuScreenBuilder,
  });

  @override
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> with TickerProviderStateMixin {

  MenuController menuController;
  ScrollController scrollController;
  // Use non-linear curves, with the down curve making all
  // the change before 0.3
  Curve scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = Interval(0.0, 0.7, curve: Curves.easeOut);
  Curve slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);

  // This property is updated by ToolbarOpacityChangeNotifications dispatched by
  // the DisappearingSpaceBarTitleState, in response to the user expanding or
  // collapsing th SliverAppBar.
  double _toolbarOpacity = 0.0;
  // ref: https://stackoverflow.com/a/50430389/1402287

  @override
  void initState() {
    super.initState();
    menuController = MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
    scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    menuController.dispose();   // deregister the listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This essentially build the entire scaffold.
    // It is all assembled under a ZoomScaffoldMenuController, which says
    // find me a MenuController from under the state widget, and pass it into
    // the builder function, which will then pass it on to the menu screen,
    // which now needs to be a builder also.

    return NotificationListener<ToolbarOpacityChangeNotification>(
      onNotification: (ToolbarOpacityChangeNotification notification) {
        _toolbarOpacity = notification.toolbarOpacity;
        return true;
      },
      child: ZoomScaffoldMenuController(
        // Need a material to prevent yellow underlined content
        // https://stackoverflow.com/a/49967268/1402287
        builder: (BuildContext context, MenuController menuController) => Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              widget.menuScreenBuilder(context, menuController),
              createContentDisplay(),
              createHalo(),
              createLeadingIcon(),
            ],
          ),
        ),
      ),
    );
  }

  createContentDisplay() {
    return zoomAndSlideContent(
        Container(
          child: widget.currentMenuItem.screenBuilder(
            context,
            scrollController,
          ),
        )
    );
  }

  createHalo() {
    // Halo/circle under leadingImage should only be shown when menu closed.
    // However, since the halo has the same color as the menu screen background,
    // it may not be noticeable, even if showHalo is always true.
    final bool hideHalo = menuController.state != MenuState.closed;
    final halo = Positioned(
      top: 4.0,
      left: 7.0,
      child: Opacity(
        opacity: hideHalo ? 0.0 : (1.0 - _toolbarOpacity),
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: greenSecondaryLight,
          ),
        ),
      ),
    );
    return halo;
  }

  createLeadingIcon() {
    return spinZoomAndSlideLeadingImage();
  }

  zoomAndSlideContent(Widget content) {
    // Use non-linear curves
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
    }

    // Slides to the right, when opening menu
    // These animations are now curved
    final slideAmount = 350.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 10.0 * menuController.percentOpen;

    // When closed, use un-transformed content.
    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        // Shadow around the content
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
            ),
          ],
        ),
        child: ClipRRect(
          // Rounded corners on the content
            borderRadius: BorderRadius.circular(cornerRadius),
            child: content
        ),
      ),
    );
  }

  spinZoomAndSlideLeadingImage() {
    final _index = widget.currentMenuItem.menuIndex;
    final _imageProvider = widget.currentMenuItem.imageProvider;

    final listOffsetY = menuController.scrollController.hasClients ? menuController.scrollController.offset : 0.0;

    // The origin here is from below the system status bar.
    // This is the same as the origin of the main list
    // Spins and slides downwards when opening menu
    final closeSize = 44.0;
    final openSize = 100.0;       // from menu_screen.dart:123

    final closeOffsetX = 10.0;    // Position in the app-bar
    final openOffsetX = 25.0;     // from menu_screen.dart
    final closeOffsetY = 7.0;     // Position in the app-bar
    // The 8.0 values are the padding top and bottom of list items
    final openOffsetY = 208.0 + _index * (8.0 + 100.0 + 8.0)
        - listOffsetY;

    final imageSize = closeSize + (openSize - closeSize) * menuController.percentOpen;

    final slideAmountX = closeOffsetX + (openOffsetX - closeOffsetX) * menuController.percentOpen;
    final slideAmountY = closeOffsetY + (openOffsetY - closeOffsetY) * menuController.percentOpen;
    final spinAngle = 4 * pi * menuController.percentOpen;

    // When closed, use un-transformed content.
    // When open, widget is effectively gone
    // Force this flag true, to show overlapped images when open for debug
    bool isVis = menuController.state != MenuState.open;
    return isVis ? Transform(
      transform: Matrix4.translationValues(
        slideAmountX ,
        slideAmountY,
        0.0,
      )
        ..rotateZ(spinAngle),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          menuController.toggle();
        },
        child: Image(
          image: _imageProvider,
          fit: BoxFit.cover,
          width: imageSize,
          height: imageSize,
        ),
      ),
    ) : Container();
  }

}

// This class allows the MenuScreen to 'know'it's in the ZoomScaffold
// and 'reach up' to access the MenuController.
class ZoomScaffoldMenuController extends StatelessWidget {
  final ZoomScaffoldBuilder builder;

  // Whoever calls this method is saying that somewhere above them in the
  // widget tree is a _ZoomScaffoldState.
  getMenuController(BuildContext context) {
    final scaffoldState = context.ancestorStateOfType(
        TypeMatcher<_ZoomScaffoldState>()
    ) as _ZoomScaffoldState;
    return scaffoldState.menuController;
  }

  ZoomScaffoldMenuController({
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, getMenuController(context));
  }
}

// Maybe need a ZoomScaffoldMenuControllerState and make ZoomScaffoldMenuController
// into a Stateful widget ?
// The state holds a MenuController, fetched in initState() using getMenuController
// and then a listener is added (also removed in dispose) and the listener
// simply calls setState.  This means that every time the menuController changes/
// it forces the ZoomScaffoldMenuController to rerun its build function
// which will rerun our builder.


// There's a function that takes in a BuildContext and a MenuController
// and it returns a Widget.  The menu system will provide one of these
// anonymous functions, and returns the Widget to be used as the menu screen.
typedef Widget ZoomScaffoldBuilder(
    BuildContext context,
    MenuController menuController,
    );

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;

  // this replaces the percentOpen field but we still need a getter for it
  final AnimationController _animationController;
  MenuState state = MenuState.closed;
  // Used for menu list control
  ScrollController scrollController = new ScrollController();

  MenuController({
    this.vsync,
  }) : _animationController = AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 500)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        // each AnimationStatus correspond to a controller state
        switch (status) {
          case AnimationStatus.forward: // just started from 0.0
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse: // just started from reverse at 1.0
            state = MenuState.closing;
            break;
          case AnimationStatus.completed: // just reached 1.0
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed: // just reached 0.0 from reverse
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }

}
enum MenuState {
  closed,
  opening,
  open,
  closing,
}
