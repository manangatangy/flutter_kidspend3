import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/primary_list_page/primary_list_page.dart';
import 'package:kidspend3/scenes.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(),
      home: PrimaryListPage(
        sceneList: russianSceneList,
      ),
    );
  }
}
