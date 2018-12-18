import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class SceneData {
  final String title;
  final String imageUrl;
  final String translation;

  SceneData({
    this.title,
    this.imageUrl,
    this.translation,
  });
}

class SceneList {
  int currentScene;
  final List<SceneData> scenes;

  SceneList({
    this.currentScene = 0,
    @required this.scenes,
  });
}

typedef void HeaderExpansionChangeListener(double percentHeaderExpanded);

class Screen {
  final WidgetBuilder contentBuilder;

  Screen({
    this.contentBuilder,
  });
}

class MenuItem {
  // Needed to locate the leadingImage in the menu list
  final int menuIndex;
  final String title;
  final ImageProvider imageProvider;
  final WidgetBuilder screenBuilder;

//  final Screen contentScreen;   // deprecated

  // The expansion-change listener is set to the ZoomScaffoldState and
  // is called by the DisappearingSpaceBarTitleState.
//  HeaderExpansionChangeListener headerExpansionChangeListener;

  MenuItem({
    this.title,
    this.menuIndex,
    this.imageProvider,
    this.screenBuilder,
  });
}
