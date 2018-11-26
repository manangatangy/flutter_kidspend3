import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/dark_grunge_bk.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        // Background of material must be transparent so that the ink can be seen
        color: Colors.transparent,
        child: Stack(
          children: [
            createMenuTitle(),
            createMenuItems(),
          ],
        ),
      ),
    );
  }

  createMenuTitle() {
    return Transform(
      transform: Matrix4.translationValues(
        -100.0, 0.0, 0.0,
      ),
      child: OverflowBox(
        // Renders beyond the screen real estate
        // Causes the rendering of the off-screen part of the text
        // which gets translated on screen to the left.
        maxWidth: double.infinity,
        alignment: Alignment.topLeft ,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Color(0x88444444),
              fontSize: 240.0,
              fontFamily: 'mermaid',
            ),
            textAlign: TextAlign.left,
            // Stops the text wrapping on to the next line
            softWrap: false,
          ),
        ),
      ),
    );
  }

  createMenuItems() {
    // USe a transform to push the whole menu list down a bit
    return Transform(
      transform:  Matrix4.translationValues(0.0, 200.0, 0.0),
      child: Column(
        children: [
          _MenuListItem(
            title: 'Person 1',
            imageAssetPath: 'assets/alogo_claire_white.png',
            isSelected: true,
          ),
          _MenuListItem(
            title: 'Person 2',
            imageAssetPath: 'assets/alogo_nina_white.png',
            isSelected: false,
          ),
          _MenuListItem(
            title: 'Person 3',
            imageAssetPath: 'assets/alogo_rachel_white.png',
            isSelected: false,
          ),
        ],
      ),
    );
  }

}

class _MenuListItem extends StatelessWidget {
  final String title;
  final String imageAssetPath;
  final bool isSelected;

  _MenuListItem({
    this.title,
    this.imageAssetPath,
    this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // The ink is drawn on the Material, which must therefore be in
      // front of the background image
      splashColor: Color(0x44000000),
      onTap: isSelected ? null : () {

      },
      child: Container(
        // Put the menu item in a full width contained so that the full width is clickable
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Image.asset(
                imageAssetPath,
                fit: BoxFit.cover,
                width: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.red : Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'bebas-neue',
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
