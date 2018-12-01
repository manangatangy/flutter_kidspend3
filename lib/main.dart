import 'package:flutter/material.dart';
import 'package:kidspend3/menu.dart';
import 'package:kidspend3/menu_screen.dart';
import 'package:kidspend3/zoom_scaffold.dart';

void main() => runApp(MyApp());
//void main() => runApp(ListDemoApp());

// via https://youtu.be/6CEjnCVdgRM?t=3013
// https://stackoverflow.com/questions/50115416/get-height-of-a-widget-using-its-globalkey-in-flutter
// https://sergiandreplace.com/flutter-animations-using-animationcontroller-and-introducing-tweens/
// https://sergiandreplace.com/flutter-animations-the-basics/
// https://sergiandreplace.com/
// https://www.didierboelens.com/
// this shows how to make circular image
// https://medium.com/@RayLiVerified/create-a-rounded-image-icon-with-ripple-effect-in-flutter-eb0f4a720b90


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  MenuItem findById(String id) =>
      menuItems.firstWhere(
              (MenuItem menuItem) => (menuItem.id == id)
      );

  /*
  assets/simpsons_homer_donut.png
    - assets/simpsons_snowball_v.png
    - assets/simpsons_hellfish.png
   */

  static final Screen screen1 = Screen(
    title: 'active-screen',
    background: new DecorationImage(
      image: AssetImage('assets/wood_bk.jpg'),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      return Center(
        child: Text(
          'SCREEN 1',
        ),
      );
    },
  );
  static final Screen screen2 = Screen(
    title: 'active-screen',
    background: new DecorationImage(
      image: AssetImage('assets/wood_bk.jpg'),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      return Center(
        child: Text(
          'SCREEN 2',
        ),
      );
    },
  );

  var selectedItemId = 'person4';
//  var activeScreen = screen1;

  @override
  Widget build(BuildContext context) {
    return ZoomScaffold(
      leadingImageProvider: findById(selectedItemId).imageProvider,
      leadingImageListIndex: menuItems.indexOf(findById(selectedItemId)),
      menuScreenBuilder:
          (BuildContext context, MenuController menuController) =>
          MenuScreen(
            menuController: menuController,
            menuItems: menuItems,
            selectedItemId: selectedItemId,
            onMenuItemSelected: (String itemId) {
              print('item selected: $itemId');
              // Update the selection
              setState(() => selectedItemId = itemId);
            },
          ),

      contentScreen: findById(selectedItemId).contentScreen,
    );
  }
}

