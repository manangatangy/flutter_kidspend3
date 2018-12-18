

import 'package:flutter/cupertino.dart';

class HeaderChangeNotification extends Notification {

  final double collapsedFraction;

  HeaderChangeNotification({
    this.collapsedFraction,
  });
}
