import 'package:flutter/cupertino.dart';

/// Notifies when there has been a change in the expansion or
/// collapsion[!] of the FlexibleSpace in the SliverAppBar
class ToolbarOpacityChangeNotification extends Notification {
  final double toolbarOpacity;
  ToolbarOpacityChangeNotification({
    this.toolbarOpacity,
  });
}

class ExtendedScrollNotification extends Notification {
}
