import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/page_transformer/page_transformer.dart';
import 'package:kidspend3/page_transformer/page_transformer_item.dart';
import 'package:kidspend3/primary_list_page/disappearing_space_bar_title.dart';
import 'package:kidspend3/primary_list_page/sticky_header.dart';
import 'package:kidspend3/scenes.dart';

class PrimaryListPage extends StatelessWidget {

  final SceneList sceneList;

  PrimaryListPage({
    this.sceneList,
  });

  // Colors.cyan[200]
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // Setting the backgroundColor here will overide that theme
            // and be used in both expanded and collapsed state. However,
            // if transparent is specified, the collapsed toolbar will
            // ignore this and use a kind of grey color.  The expanded
            // color is, however transparent.
            backgroundColor: Colors.orangeAccent,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 450.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: DisappearingSpaceBarTitle(
                child: Text(
                  'List of Items',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              background: Container(
                // This color is only used in expanded state; the collapsed
                // color is the normal appBar color; either from the theme
                // or set in SliverAppBar.backgroundColor.  Note that if you
                // set this color to transparent, then the normal appBar
                // color will appear in expanded state.
                color: Theme
                    .of(context)
                    .canvasColor,
                child: BackgroundPageTransformer(
                  sceneList: sceneList,
                ),
              ),
            ),
          ),
//          StickyHeader(),

//          SliverPersistentHeader(
//            pinned: true,
//            delegate: _SliverAppBarDelegate(
//              minHeight: _kAppBarMinHeight,
//              maxHeight: appBarMaxHeight,
//            ),
//          ),

          SliverList(
            delegate: new SliverChildListDelegate(
              List.generate(10, (index) =>
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('item number $index'),
                  )),
            ),
          ),
          StickyHeader(),
          SliverList(
            delegate: new SliverChildListDelegate(
              List.generate(10, (index) =>
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('item number $index'),
                  )),
            ),
          ),
          StickyHeader(),
          SliverList(
            delegate: new SliverChildListDelegate(
              List.generate(10, (index) =>
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('item number $index'),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPageTransformer extends StatelessWidget {
  final SceneList sceneList;

  BackgroundPageTransformer({
    this.sceneList,
  });

  @override
  Widget build(BuildContext context) {
    return PageTransformer(
      pageViewBuilder: (context, visibilityResolver) {
        return PageView.builder(
          controller: PageController(
            viewportFraction: 0.85,
            initialPage: sceneList.currentScene,
          ),
          onPageChanged: (int page) {
            sceneList.currentScene = page;
          },
          itemCount: sceneList.scenes.length,
          itemBuilder: (context, index) {
            final vis = visibilityResolver.resolvePageVisibility(index);
            return PageItem(
              sceneData: sceneList.scenes[index],
              pageVisibility: vis,
            );
          },
        );
      },
      itemCount: sceneList.scenes.length,
    );
  }
}
