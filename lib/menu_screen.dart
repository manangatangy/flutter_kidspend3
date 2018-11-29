import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidspend3/main.dart';
import 'package:kidspend3/zoom_scaffold.dart';

final menuScreenKey = GlobalKey(debugLabel: 'MenuScreen');

class MenuScreen extends StatefulWidget {
  final MenuController menuController;
  final List<MenuItem> menuItems;
  final String selectedItemId;
  final Function(String) onMenuItemSelected;

  MenuScreen({
    this.menuController,
    this.menuItems,
    this.selectedItemId,
    this.onMenuItemSelected,
    // By providing a key to the ctor, we can then ask to fetch the
    // state object associated with that key. This is allowed because
    // no other widget may have this key.
  }) : super(key: menuScreenKey);

  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {

  AnimationController titleAnimationController;
  RenderBox selectedRenderBox;

  void setSelectedRenderBox(newRenderBox) {
    // This could prob be a setter and the field made private
    // but I'm not sure we actually need to setState to change this
    setState(() {
      selectedRenderBox = newRenderBox;
    });
  }
  @override
  void initState() {
    super.initState();
    titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),

    );
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedRenderBox == null) {
      print('Selected render box is null');
    } else {
      print('Selected render box has y position: ${selectedRenderBox.localToGlobal(const Offset(0.0, 0.0)).dy}');
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/dark_grunge_bk.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        // Background of material must be transparent so that the ink can be seen
        color: Colors.transparent,
        child: Stack(
          children: [
            createMenuTitle(widget.menuController),
            createMenuItems(widget.menuController, widget.menuItems),
          ],
        ),
      ),
    );
  }

  createMenuTitle(MenuController menuController) {
    switch (menuController.state) {
      case MenuState.open:
      case MenuState.opening:
        titleAnimationController.forward();
        break;
      case MenuState.closed:
      case MenuState.closing:
      titleAnimationController.reverse();
      break;
    }

    // Instead of returning the built widget, return a builder.
    return AnimatedBuilder(
        animation: titleAnimationController,
        // This child is the static definition of the menu-title and it will
        // be animated by the builder method.
        child: OverflowBox(
          // Renders beyond the screen real estate
          // Causes the rendering of the off-screen part of the text
          // which gets translated on screen to the left.
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Color(0x88444444),
                fontSize: 240.0,
                fontFamily: 'mermaid',
              ),
              textAlign: TextAlign.left,
              // Stops the text wrapping on to the next line
              softWrap: false,
            ),
          ),
        ),
        // The builder function will be run every time the animation changes.
        // The child passed to this builder is the child field of the
        // AnimatedBuilder
        builder: (BuildContext context, Widget child) {
          return Transform(
            transform: Matrix4.translationValues(
              // -80.0 is the offset to the left
              -240.0,
              -100 + 500.0 * (titleAnimationController.value - 1.0),
              0.0,
            ),
            child: Transform.rotate(
              angle: pi/2.0,
              child: child,
            ),
          );
        }
    );
  }

   createMenuItems(MenuController menuController, List<MenuItem> menuItems) {
     // Use a transform to push the whole menu list down a bit

     return Transform(
       transform: Matrix4.translationValues(0.0, 200.0, 0.0),
       child: Column(
         children: Iterable.generate(
             menuItems.length,
                 (int index) =>
                 AnimatedMenuListItem(
                   menuState: menuController.state,
                   isSelected: menuItems[index].id == widget.selectedItemId,
                   duration: Duration(
                     milliseconds: menuController.state == MenuState.closing
                         ? 200 : 600,
                   ),
                   curve: menuController.state == MenuState.closing
                       ? Curves.easeIn
                       : Interval(
                       0.0 + index * 0.2,
                       0.5 + index * 0.2,
                       curve: Curves.easeOut),
                   menuListItem: _MenuListItem(
                       title: menuItems[index].title,
                       imageProvider: menuItems[index].imageProvider,
                       isSelected: menuItems[index].id == widget.selectedItemId,
                       onTap: () {
                         widget.onMenuItemSelected(menuItems[index].id);
                         menuController.close();
                       }
                   ),
                 )
         ).toList(),
       ),
     );
   }
}

// Now lets wrap each list item in an animator
// Change 'extends StatefulWidget' to ImplicitlyAnimatedWidget and
// also change 'extends State<' to AnimatedWidgetBaseState which requires
// implementing method forEachTween.   An ImplicitlyAnimatedWidget says
// 'something about me can be animated', ie some value can change.
// So we bring in the properties we're going to need.  This widget will
// wrap a menuListItem

class AnimatedMenuListItem extends ImplicitlyAnimatedWidget {

  final _MenuListItem menuListItem;
  // Also need to know if we're sliding up/down etc, and what the duration should be
  final MenuState menuState;
  final Duration duration;
  final bool isSelected;

  AnimatedMenuListItem({
    this.menuState,
    this.menuListItem,
    this.duration,
    this.isSelected,
    curve,
  }) : super(duration: duration, curve: curve);

  @override
  _AnimatedMenuListItemState createState() => new _AnimatedMenuListItemState();
}

class _AnimatedMenuListItemState extends AnimatedWidgetBaseState<AnimatedMenuListItem> {

  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  // Animating two things
  Tween<double> _translation;
  Tween<double> _opacity;

  // The render tree is a long-lived structure that performs the writes to
  // the screen.  Cf. the widget tree which is short-lived.

  updateSelectedRenderBox() {
    // The context is a build context and it represents where in the
    // render tree this list item it, so the context is different for
    // every widget.  Most render objects are RenderBox

    final renderBox = context.findRenderObject() as RenderBox;
    if (renderBox != null && widget.isSelected) {
      // may be null on the initial build pass.
      // Where is local-topleft in the global screen
//      print('My renderBox local: ${renderBox.localToGlobal(const Offset(0.0, 0.0))}');
      // The following couples the listItem to the MenuScreen which in general
      // is not a great idea.
      (menuScreenKey.currentState as _MenuScreenState).selectedRenderBox = renderBox;
    }
  }

  @override
  void forEachTween(visitor) {
    var slideTarget, opacityTarget;

    switch (widget.menuState) {
      case MenuState.closing:
      case MenuState.closed:
        // Set the slide/opacity 'goals'
        slideTarget = closedSlidePosition;
        opacityTarget = 0.0;
        break;
      case MenuState.open:
      case MenuState.opening:
        slideTarget = openSlidePosition;
        opacityTarget = 1.0;
        break;
    }

    // Adjust the tweens,
    _translation = visitor(
      _translation,
      slideTarget,
      (dynamic value) => Tween<double>(begin: value),
    );

    _opacity = visitor(
      _opacity,
      opacityTarget,
      (dynamic value) => Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateSelectedRenderBox();
    
    return new Opacity(
      // Use the tweened value, evaluated from the base class animation.
        opacity: _opacity.evaluate(animation),
      child: Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translation.evaluate(animation),
          0.0,
        ),
        child: widget.menuListItem,
      ),
    );
  }

}

class _MenuListItem extends StatelessWidget {
  final String title;
  final ImageProvider imageProvider;
  final bool isSelected;
  final Function() onTap;

  _MenuListItem({
    this.title,
    this.imageProvider,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // The ink is drawn on the Material, which must therefore be in
      // front of the background image
      splashColor: Color(0x44000000),
      onTap: isSelected ? null : onTap,
      child: Container(
        // Put the menu item in a full width contained so that the full width is clickable
        width: double.infinity,
        child: Padding(
          // Don't forget to add the top/bottom to the leadingImage position
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: 100.0,
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.red : Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'bebas-neue',
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
