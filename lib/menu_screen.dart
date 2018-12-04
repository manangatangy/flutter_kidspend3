import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidspend3/menu.dart';
import 'package:kidspend3/zoom_scaffold.dart';

final menuScreenKey = GlobalKey(debugLabel: 'MenuScreen');

class MenuScreen extends StatefulWidget {
  final MenuController menuController;
  final String selectedItemId;
  final Function(String) onMenuItemSelected;
  final List<MenuItem> menuItems;

  MenuScreen({
    this.menuController,
    this.selectedItemId,
    this.onMenuItemSelected,
    this.menuItems,
    // By providing a key to the ctor, we can then ask to fetch the
    // state object associated with that key. This is allowed because
    // no other widget may have this key.
  }) : super(key: menuScreenKey);

  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  AnimationController titleAnimationController;

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
              angle: pi / 2.0,
              child: child,
            ),
          );
        });
  }

  Interval incrementedInterval(int index, double incr) {
    var begin = 0.3 + index * incr;
    var end = begin + 0.2;
    return Interval(begin, end > 1.0 ? 1.0 : end, curve: Curves.easeOut);
  }

  createMenuItems(MenuController menuController, List<MenuItem> menuItems) {
    final incr = 0.5 / menuItems.length;
    return Padding(
      // The origin here is below the system status bar
      padding: EdgeInsets.only(top: 200.0),
      child: ListView(
        controller: widget.menuController.scrollController,
        children: Iterable.generate(
            menuItems.length,
                (int index) =>
                AnimatedMenuListItem(
                  menuState: menuController.state,
                  isSelected: menuItems[index].id == widget.selectedItemId,
                  duration: Duration(
                    milliseconds: menuController.state == MenuState.closing ? 200 : 600,
                  ),
                  curve: menuController.state == MenuState.closing
                      ? Curves.easeIn
                      : incrementedInterval(index, incr),
                  menuListItem: _MenuListItem(
                      title: menuItems[index].title,
                      imageProvider: menuItems[index].imageProvider,
                      isSelected: menuItems[index].id == widget.selectedItemId,
                      menuState: menuController.state,
                      onTap: () {
                        widget.onMenuItemSelected(menuItems[index].id);
                        menuController.close();
                      }),
                ))
            .toList(),
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

class _AnimatedMenuListItemState
    extends AnimatedWidgetBaseState<AnimatedMenuListItem> {
  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  // Animating two things
  Tween<double> _translation;
  Tween<double> _opacity;

  // The render tree is a long-lived structure that performs the writes to
  // the screen.  Cf. the widget tree which is short-lived.

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
    return Row(
      children: [
        Opacity(
          opacity: _opacity.evaluate(animation),
          child: Container(
            width: 5.0,
            height: 100.0 + 8.0 + 8.0,
            // The selection indicator is shown if the item is selected.
            color: widget.isSelected ? Colors.red : Colors.transparent,
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            _translation.evaluate(animation),
            0.0,
            0.0,
          ),
          child: widget.menuListItem,
        ),
      ],
    );
  }
}

class _MenuListItem extends StatelessWidget {
  final String title;
  final ImageProvider imageProvider;
  final bool isSelected;
  final Function() onTap;
  final MenuState menuState;

  _MenuListItem({
    this.title,
    this.imageProvider,
    this.isSelected,
    this.onTap,
    this.menuState,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      // The ink is drawn on the Material, which must therefore be in
      // front of the background image
      splashColor: Color(0x44000000),
//      onTap: isSelected ? null : onTap,     // Disallow click if already selected
      onTap: onTap,
      child: Container(
        // Put the menu item in a full width contained so that the full width is clickable
        // The width was previously double.infinity, however this conflicted with having a
        // parent Row for holding the selection-indicator, so reset with to screen width.
      width: screenWidth - 5.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8.0),
              // The image is show either if the item is not selected or it
              // the menu state is fully open (ie, animated has stopped).
              child: !isSelected || menuState == MenuState.open ? Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: 100.0,
                height: 100.0,
              ) : Container(
                width: 100.0,
                height: 100.0,
              ),
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
    );
  }
}
