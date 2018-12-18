

import 'package:flutter/cupertino.dart';

class HeaderChangeNotification extends Notification {

  final double collapsedFraction;

  HeaderChangeNotification({
    this.collapsedFraction,
  });
}

// https://stackoverflow.com/questions/53483048/unhandled-exception-in-futurebuilder-flutter

