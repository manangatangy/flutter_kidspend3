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
  String tag;
  int currentScene;
  final List<SceneData> scenes;

  SceneList({
    this.tag,
    this.currentScene = 0,
    @required this.scenes,
  });
}

typedef Widget ScreenBuilder(BuildContext context,
    ScrollController scrollController,);

class MenuItem {
  // Needed to locate the leadingImage in the menu list
  final int menuIndex;
  final String title;
  final ImageProvider imageProvider;
  final ScreenBuilder screenBuilder;

  MenuItem({
    this.title,
    this.menuIndex,
    this.imageProvider,
    this.screenBuilder,
  });
}
