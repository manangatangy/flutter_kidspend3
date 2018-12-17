import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/primary_list_page/primary_list_page.dart';
import 'package:kidspend3/scaffold/menu_screen.dart';
import 'package:kidspend3/scaffold/zoom_scaffold.dart';
import 'package:kidspend3/menu_and_scene_data/menu_record.dart';
import 'package:kidspend3/menu_and_scene_data/scenes-1.dart';
import 'package:kidspend3/menu_and_scene_data/scenes-2.dart';

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

Map<String, MenuItem> _menuItems = {
  'person-key-0': MenuItem(
//    id: 'person-key-0',
    menuIndex: 0,
    title: 'Person 0',
    imageProvider: AssetImage("assets/face1-trans.png"),
    contentScreen: Screen(
      contentBuilder: (BuildContext context) => PrimaryListPage(
        sceneList: russianSceneList,
      ),
    ),
  ),
  'person-key-1': MenuItem(
//    id: 'person-key-1',
    menuIndex: 1,
    title: 'Person 1',
    imageProvider: AssetImage("assets/face2-trans.png"),
    contentScreen: Screen(
      contentBuilder: (BuildContext context) => PrimaryListPage(
        sceneList: deruedaSceneList,
      ),
    ),
  ),
  'person-key-2': MenuItem(
//    id: 'person-key-2',
    menuIndex: 2,
    title: 'Person 2',
    imageProvider: AssetImage("assets/face3-trans.png"),
    contentScreen: Screen(
      contentBuilder: (BuildContext context) => PrimaryListPage(
        sceneList: deruedaSceneList,
      ),
    ),
  ),

};

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//  MenuItem findById(String id) =>
//      menuItems.firstWhere(
//              (MenuItem menuItem) => (menuItem.id == id)
//      );
//
  // Initially selected menu item.
  String _selectedMenuItemKey = 'person-key-0';

  @override
  Widget build(BuildContext context) {
    MenuItem _selectedMenuItem = _menuItems[_selectedMenuItemKey];

//    List<MapEntry<String, MenuItem>> entries = menuItems.entries.toList();
//    List<Container> widgets = Iterable.generate(
//      menuItems.length,
//          (int index) => Container(
//
//          )).toList();

    return ZoomScaffold(
      contentScreen: _selectedMenuItem.contentScreen,
      leadingImageProvider: _selectedMenuItem.imageProvider,
      leadingImageListIndex: _selectedMenuItem.menuIndex,
      menuScreenBuilder:
          (BuildContext context, MenuController menuController) =>
          MenuScreen(
            menuController: menuController,
            menuEntries: _menuItems.entries.toList(),
            selectedItemKey: _selectedMenuItemKey,
            onMenuItemSelected: (String itemKey) {
              setState(() => _selectedMenuItemKey = itemKey);
            },
          ),
    );
  }
}
