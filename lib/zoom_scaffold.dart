
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidspend3/menu_screen.dart';
import 'package:kidspend3/menu_screen.dart';

class ZoomScaffold extends StatefulWidget {
  final Widget leading;
  final Widget menuScreen;
  final Screen contentScreen;

  ZoomScaffold({
    this.leading,
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> {

  bool isClosed = false;

  createLeadingIcon() {
    return spinZoomAndSlideLeadingIcon(
      widget.leading,
    );
  }

  createContentDisplay() {
    return zoomAndSlideContent(
//      widget.contentScreen,


        Container(
          decoration: BoxDecoration(
            image: widget.contentScreen.background,
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 40.0,
                  left: 160.0,
                  child: Text(
                    'hello',
                    style: TextStyle(
                      fontFamily: 'bebas-neue',
                      fontSize: 25.0,
                    ),
                  )
              ),
              widget.contentScreen.contentBuilder(context),
            ],



//            backgroundColor: Colors.transparent,
//            appBar: AppBar(
//              backgroundColor: Colors.transparent,
//              elevation: 0.0,
//              title: Text(
//                widget.contentScreen.title,
//                style: TextStyle(
//                  fontFamily: 'bebas-neue',
//                  fontSize: 25.0,
//                ),
//                textAlign: TextAlign.right,
//              ),
////              leading: IconButton(
////                icon: Icon(Icons.menu),
////                onPressed: () {
////
////                },
////              ),
//            ),
//            body: widget.contentScreen.contentBuilder(context),

          ),
        )
    );
  }

  zoomAndSlideContent(Widget content) {
    // Slides to the right, when opening menu
    return isClosed ? content : Transform(
      transform: Matrix4.translationValues(275.0, 0.0, 0.0)
        ..scale(0.8, 0.8),
      alignment: Alignment.centerLeft,
      child: content,
    );
  }

  spinZoomAndSlideLeadingIcon(Widget leadingIcon) {
    // Spins and slides downwards when opening menu
    return isClosed ? Transform(
      transform: Matrix4.translationValues(0.0, 20.0, 0.0),
      child: leadingIcon,
    ) : Transform(
      transform: Matrix4.translationValues(0.0, 150.0, 0.0)
        ..scale(1.8, 1.8),
      alignment: Alignment.topLeft,
      child: leadingIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Need a material to prevent yellow underlined content
    // https://stackoverflow.com/a/49967268/1402287
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          widget.menuScreen,
          createContentDisplay(),
          // The leading widget needs a touch-detector and an onPressed field
          createLeadingIcon(),
        ],
      ),
    );
  }

}

class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;

  Screen({
    this.title,
    this.background,
    this.contentBuilder,
  });
}
