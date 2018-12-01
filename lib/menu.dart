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

final image1 = AssetImage("assets/simpsons_snowball_v.png");
final image2 = AssetImage('assets/snowball-bk.png');

final List<MenuItem> menuItems = [
//    MenuItem(
//      id: 'person1',
//      title: 'Angry Person',
//      imageProvider: AssetImage("assets/alogo_claire_white.png"),
//    ),
//    MenuItem(
//      id: 'person2',
//      title: 'Sweet Person',
//      imageProvider: AssetImage("assets/alogo_nina_white.png"),
//    ),
//    MenuItem(
//      id: 'person3',
//      title: 'Crazy Person',
//      imageProvider: AssetImage("assets/alogo_rachel_white.png"),
//    ),
  MenuItem(
    id: 'person4',
    title: 'Hellfish',
    imageProvider: AssetImage("assets/simpsons_hellfish.png"),
    contentScreen: Screen(
      title: 'Hell Fish',
      background: new DecorationImage(
        image: AssetImage('assets/hellfish-bk.png'),
        fit: BoxFit.cover,
      ),
      contentBuilder: (BuildContext context) {
        return Center(child: Text('',),);
      },
    ),
  ),
  MenuItem(
    id: 'person6',
    title: 'Homer-donut',
    imageProvider: AssetImage("assets/simpsons_homer_donut.png"),
    contentScreen: Screen(
      title: 'Donut list',
      background: new DecorationImage(
        image: AssetImage('assets/donut-bk.png'),
        fit: BoxFit.cover,
      ),
      contentBuilder: (BuildContext context) {
        return Center(child: Text('',),);
      },
    ),
  ),
  MenuItem(
    id: 'person5',
    title: 'Snowball-V',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(
        image: image2,
        fit: BoxFit.cover,
      ),
      contentBuilder: (BuildContext context) {
        return Center(child: Text('',),);
      },
    ),
  ),


  MenuItem(
    id: '1person5',
    title: 'Snowball-V',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image2, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),

  MenuItem(
    id: '2person5',
    title: 'Snowball-V',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image2, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: '3person5',
    title: 'Snowball-V',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image2, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: '4person5',
    title: 'Snowball-V',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image2, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),
  MenuItem(
    id: '5person5',
    title: 'Snowball-V',
    imageProvider: image1,
    contentScreen: Screen(
      title: 'Lisa & Snowball-V',
      background: new DecorationImage(image: image2, fit: BoxFit.cover,),
      contentBuilder: (BuildContext context) {return Center(child: Text('',),);},
    ),
  ),

];
