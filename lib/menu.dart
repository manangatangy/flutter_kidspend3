import 'package:flutter/cupertino.dart';
import 'package:kidspend3/zoom_scaffold.dart';

class MenuItem {
  final String id;
  final String title;
  final ImageProvider imageProvider;
  final Screen contentScreen;

  MenuItem({
    this.id,
    this.title,
    this.imageProvider,
    this.contentScreen,
  });
}

final image1 = AssetImage("assets/simpsons_hellfish.png");
final image1Bk = AssetImage('assets/hellfish-bk.png');
final image2 = AssetImage("assets/simpsons_homer_donut.png");
final image2Bk = AssetImage('assets/donut-bk.png');
final image3 = AssetImage("assets/simpsons_snowball_v.png");
final image3Bk = AssetImage('assets/snowball-bk.png');

final List<MenuItem> menuItems = [
  MenuItem(
    id: 'Hellfish-A',
    title: 'Hellfish-A',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Hell Fish',
      background: new DecorationImage(image: image1Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Homer-A',
    title: 'Homer-A',
    imageProvider: image2,
    contentScreen: Screen(
      title: 'Donut list',
      background: new DecorationImage(image: image2Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Snowball-A',
    title: 'Snowball-A',
    imageProvider: image3,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image3Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Hellfish-B',
    title: 'Hellfish-B',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Hell Fish',
      background: new DecorationImage(image: image1Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Homer-B',
    title: 'Homer-B',
    imageProvider: image2,
    contentScreen: Screen(
      title: 'Donut list',
      background: new DecorationImage(image: image2Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Snowball-B',
    title: 'Snowball-B',
    imageProvider: image3,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image3Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Hellfish-C',
    title: 'Hellfish-C',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Hell Fish',
      background: new DecorationImage(image: image1Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Homer-C',
    title: 'Homer-C',
    imageProvider: image2,
    contentScreen: Screen(
      title: 'Donut list',
      background: new DecorationImage(image: image2Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: 'Snowball-C',
    title: 'Snowball-C',
    imageProvider: image3,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image3Bk, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),

];
