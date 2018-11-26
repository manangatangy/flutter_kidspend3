import 'package:flutter/material.dart';
import 'package:kidspend3/menu_screen.dart';
import 'package:kidspend3/restaurant_screen.dart';
import 'package:kidspend3/zoom_scaffold.dart';

void main() => runApp(MyApp());

// via https://youtu.be/6CEjnCVdgRM?t=3013
// https://stackoverflow.com/questions/50115416/get-height-of-a-widget-using-its-globalkey-in-flutter
// https://sergiandreplace.com/flutter-animations-using-animationcontroller-and-introducing-tweens/
// https://sergiandreplace.com/flutter-animations-the-basics/
// https://sergiandreplace.com/
// https://www.didierboelens.com/


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

class Menu {
  final List<MenuItem> items;

  Menu({
    this.items,
  });
}

class MenuItem {
  final String id;
  final String title;
  final ImageIcon icon;

  MenuItem({
    this.id,
    this.title,
    this.icon,
  });
}

class _MyHomePageState extends State<MyHomePage> {

  final menu = Menu(
    items: [
      MenuItem(
        id: 'person1',
        title: 'First Person',
        icon: ImageIcon(
            AssetImage("assets/alogo_claire_white.png")
        ),
      ),
      MenuItem(
        id: 'person2',
        title: 'First Person',
        icon: ImageIcon(
            AssetImage("assets/alogo_nina_white.png")
        ),
      ),
      MenuItem(
        id: 'person3',
        title: 'First Person',
        icon: ImageIcon(
            AssetImage("assets/alogo_rachel_white.png")
        ),
      ),
    ],
  );

  Screen activeScreen = Screen(
    title: 'active-screen',
    background: new DecorationImage(
      image: new AssetImage('assets/wood_bk.jpg'),
      fit: BoxFit.cover,
    ),
    contentBuilder: (BuildContext context) {
      return Center(
        child: Text(
          'some content',
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return ZoomScaffold(
      menuScreen: MenuScreen(),



      contentScreen: activeScreen,



      //contentScreen: activeScreen,
      leading: Image.asset(
        'assets/alogo_claire_white.png',
        fit: BoxFit.cover,
        width: 60.0,
      ),
    );
  }
}

