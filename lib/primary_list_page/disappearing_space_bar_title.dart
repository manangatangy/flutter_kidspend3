import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/scaffold/zoom_image.dart';

/// The [title] property of the [FlexibleSpaceBar] appears in both the
/// expanded and collapsed state.  This widget can be used as the [title]
/// and will disappear it's child when the state is expanded.  This is
/// useful if you want the expanded space bar to only show the [background].
class DisappearingSpaceBarTitle extends StatefulWidget {

  DisappearingSpaceBarTitle({
    this.child,
  });

  final Widget child;

  @override
  DisappearingSpaceBarTitleState createState() {
    return new DisappearingSpaceBarTitleState();
  }
}

class DisappearingSpaceBarTitleState extends State<DisappearingSpaceBarTitle> {
  @override
  Widget build(BuildContext context) {

    // Arithmetic mostly derived from FlexibleSpaceBar.build()
    final FlexibleSpaceBarSettings settings = context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);
    assert(settings != null, 'A DisappearingSpaceBarTitle must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().');

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);

    final double fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
    const double fadeEnd = 1.0;
    assert(fadeStart <= fadeEnd);
    final double opacity = Interval(fadeStart, fadeEnd).transform(t);

    // This could be used to interpolate a color transition
//    final Color c = ColorTween(
//        begin: Colors.black,
//        end: Colors.blue,
//    ).transform(t);
    ToolbarOpacityChangeNotification(
      toolbarOpacity: opacity,
    )..dispatch(context);

    return Opacity(
        opacity: opacity,
        child: widget.child,
    );
  }
}
