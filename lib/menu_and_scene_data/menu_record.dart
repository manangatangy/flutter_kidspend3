import 'package:flutter/cupertino.dart';
import 'package:kidspend3/scaffold/zoom_scaffold.dart';
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
//  final String title;
//  final AssetImage backgroundImage;
  final WidgetBuilder contentBuilder;

  Screen({
//    this.title,
//    this.backgroundImage,
    this.contentBuilder,
  });
}

class MenuItem {
  // id is needed in _MenuScreenState.createMenuItems to check if the
  // menu item is the selected one.  Must be equal to the menuItems.key
//  final String id;
  // Needed to locate the leadingImage in the menu list
  final int menuIndex;
  final String title;
  final ImageProvider imageProvider;
//  final SceneList sceneList;
  final Screen contentScreen;   // deprecated

  // The expansion-change listener is set to the ZoomScaffoldState and
  // is called by the DisappearingSpaceBarTitleState.
  HeaderExpansionChangeListener headerExpansionChangeListener;

  MenuItem({
    this.title,
    this.menuIndex,
    this.imageProvider,
    this.contentScreen,
//    this.sceneList,
  });
}
