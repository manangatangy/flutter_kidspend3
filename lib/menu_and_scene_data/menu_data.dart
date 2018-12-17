import 'package:flutter/cupertino.dart';
import 'package:kidspend3/menu_and_scene_data/scenes-1.dart';
import 'package:kidspend3/menu_and_scene_data/scenes-2.dart';
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

class MenuItem {
  final String id;    // deprecated
  final String title;
  final ImageProvider imageProvider;
  final Screen contentScreen;   // deprecated
  final SceneList sceneList;

  MenuItem({
    this.id,
    this.title,
    this.imageProvider,
    this.contentScreen,
    this.sceneList,
  });
}

Map<String, MenuItem> menuItems = {
  'person-key-1': MenuItem(
    title: '',
    imageProvider: null,
    sceneList: russianSceneList,
  ),
  'person-key-2': MenuItem(
    title: '',
    imageProvider: null,
    sceneList: deruedaSceneList,
  ),

};


// deruedaSceneList