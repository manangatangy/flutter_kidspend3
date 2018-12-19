
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo app',
      home: MyHome(),
    );
  }
}

/// Notifies when there has been a change in the expansion or
/// collapsion[!] of the FlexibleSpace in the SliverAppBar
class ToolbarOpacityChangeNotification extends Notification {
  final double toolbarOpacity;
  ToolbarOpacityChangeNotification({
    this.toolbarOpacity,
  });
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  double _toolbarOpacity = 0.5;

  @override
  Widget build(BuildContext context) {

//    final double visibleMainHeight = maxExtent - shrinkOffset - topPadding;
//    final double toolbarOpacity =
//        (visibleMainHeight - _bottomHeight) / kToolbarHeight).clamp(0.0, 1.0);

    return NotificationListener<ToolbarOpacityChangeNotification>(
      onNotification: (ToolbarOpacityChangeNotification notification) {
        _toolbarOpacity = notification.toolbarOpacity;
        print('onToolbarOpacityChangeNotification _toolbarOpacity: $_toolbarOpacity');
        return true;
      },
      child: Stack(
        children: <Widget>[
          Material(
            // The CustomScrollView must be the immediate child of the
            // ScrollNotification for the notification to occur.
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                // This notification occurs when the CustomScrollView is scrolled
                if (notification.runtimeType == ScrollUpdateNotification) {
                  ScrollUpdateNotification scrollUpdateNotification = notification as ScrollUpdateNotification;
                  print('2.onScrollUpdateNotification');
                  setState(() {});
                }
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: MyFlexibleSpaceBarTitle(
                        // The MyFlexibleSpaceBarTitle widget
                        child: Text('A List of Items'),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) =>
                        ListTile(
                          title: Text('List tile #$i'),
                        ),
                      childCount: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _toolbarOpacity,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}

class MyFlexibleSpaceBarTitle extends StatefulWidget {
  final Widget child;

  MyFlexibleSpaceBarTitle({
    this.child,
  });

  @override
  _MyFlexibleSpaceBarTitleState createState() => _MyFlexibleSpaceBarTitleState();
}

class _MyFlexibleSpaceBarTitleState extends State<MyFlexibleSpaceBarTitle> {
  @override
  Widget build(BuildContext context) {

    // Arithmetic mostly derived from FlexibleSpaceBar.build()
    final FlexibleSpaceBarSettings settings = context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);
    assert(settings != null, 'No FlexibleSpaceBarSettings found');
    final double deltaExtent = settings.maxExtent - settings.minExtent;
    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);
    final double fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
    const double fadeEnd = 1.0;
    assert(fadeStart <= fadeEnd);
    final double opacity = Interval(fadeStart, fadeEnd).transform(t);

    print('_MyFlexibleSpaceBarTitleState.build settings.toolbarOpacity: ${settings.toolbarOpacity}');
    print('_MyFlexibleSpaceBarTitleState.build opacity: $opacity');

    // This is probably wrong ?
    ToolbarOpacityChangeNotification(
      toolbarOpacity: opacity,
    )..dispatch(context);

    return Opacity(
      opacity: opacity,
      child: widget.child,
    );
  }
}
