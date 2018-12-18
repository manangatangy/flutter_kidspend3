import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kidspend3/primary_list_page/primary_list_page.dart';
import 'package:kidspend3/scaffold/menu_screen.dart';
import 'package:kidspend3/scaffold/zoom_scaffold.dart';
import 'package:kidspend3/menu_and_scene_data/menu_record.dart';
import 'package:kidspend3/menu_and_scene_data/scenes-1.dart';
import 'package:kidspend3/menu_and_scene_data/scenes-2.dart';

main() => runApp(MyApp());

// Ref: https://material-ui.com/style/color/ with
// primary: green A100
// secondary: green A400
final greenPrimaryDark = Color(0xff81ac8d);
final greenPrimaryMedium = Color(0xffb9f6ca);
final greenPrimaryLight = Color(0xffc7f7d4);
final greenSecondaryDark = Color(0xff00a152);
final greenSecondaryMedium = Color(0xff00e676);
final greenSecondaryLight = Color(0xff33eb91);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    // Ref: https://stackoverflow.com/a/51269484/1402287
    // This sets the status bar color.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: greenPrimaryDark,
    ));

    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primaryColorDark: greenPrimaryDark,
        primaryColor: greenPrimaryMedium,
        primaryColorLight: greenPrimaryLight,
        accentColor: greenSecondaryMedium,
        accentColorBrightness: Brightness.light,
      ),

      // To reserve space for the status bar, we can wrap the app in a
      // SafeArea, or wrap it in a Scaffold, with an empty appBar property;
      // Ref: https://github.com/flutter/flutter/issues/4518#issuecomment-424298638
      // and: https://github.com/flutter/flutter/issues/4518#issuecomment-393816831
      // Note however that simply wrapping the child in a SafeAre as described in
      // https://github.com/flutter/flutter/issues/4518#issuecomment-397117406
      // leaves the status bar black (although it did reserve space for it).
      // Note that the actual status bar height if you need it, can be found from:
      // ref: final double statusBarHeight = MediaQuery.of(context).padding.top;
      // and it seems to 24.0

      home: SafeArea(
        child: MyHomePage(),
      ),
    );
  }
}

Map<String, MenuItem> _menuItems = {
  'person-key-0': MenuItem(
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

  // Initially selected menu item.
  String _selectedMenuItemKey = 'person-key-0';

  @override
  Widget build(BuildContext context) {

    MenuItem _selectedMenuItem = _menuItems[_selectedMenuItemKey];

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
