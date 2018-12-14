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
      theme: ThemeData(
        // from https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=9C27B0
//        primaryColor: Colors.purple[500],
//        primaryColorLight: Colors.purple[200],
//        primaryColorDark: Colors.purple[700],

        // cyan.2
        // from https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=B2EBF2
//        primaryColor: Colors.cyan[100],
//        primaryColorLight: Color(0xffe5ffff),
//        primaryColorDark: Color(0xff81b9bf),

        primaryColor: Color(0xff80deea),
        primaryColorLight: Color(0xffb4ffff),
        primaryColorDark: Color(0xff4bacb8),
      ),
      home: PrimaryListPage(
        sceneList: russianSceneList,
      ),
    );
  }
}
