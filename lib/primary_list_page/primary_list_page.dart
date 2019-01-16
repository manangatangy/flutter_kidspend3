import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/menu_and_scene_data/menu_record.dart';
import 'package:kidspend3/page_transformer/page_transformer.dart';
import 'package:kidspend3/page_transformer/page_transformer_item.dart';
import 'package:kidspend3/primary_list_page/disappearing_space_bar_title.dart';
import 'package:kidspend3/primary_list_page/sticky_header.dart';

class PrimaryListPage extends StatelessWidget {

  final SceneList sceneList;
  final ScrollController scrollController;

  PrimaryListPage({
    this.sceneList,
    this.scrollController,
  });

  // Colors.cyan[200]
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        key: PageStorageKey<String>(sceneList.tag + '-1'),
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            // Setting the backgroundColor here will overide that theme
            // and be used in both expanded and collapsed state. However,
            // if transparent is specified, the collapsed toolbar will
            // ignore this and use a kind of grey color.  The expanded
            // color would be, however transparent.

            // Setting floating to true causes header to re-expand
            // when you scroll down, even if you haven’t reached
            // the top of the list.  If you add both the snap parameter
            // with the floating parameter, you can make the app bar fully
            // snap back into view when you scroll down.
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 550.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: DisappearingSpaceBarTitle(
                child: Text(
                  'List of Items',
                  style: TextStyle(
                    // This style correctly uses a dark text
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
                    .scaffoldBackgroundColor,
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

          /*
SliverList(
    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      // To convert this infinite list to a list with three items,
      // uncomment the following line:
      // if (index > 3) return null;
      return Container(color: getRandomColor(), height: 150.0);
    },
    // Or, uncomment the following line:
    // childCount: 3,
  ),
);
           */
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) =>
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 6.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Colors.blueGrey))),
                        child: Icon(Icons.autorenew, color: Colors.blueGrey),
                      ),
                      title: Text(
                        'tile #$i',
                        style: TextStyle(color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              childCount: 15,
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
          key: PageStorageKey<String>(sceneList.tag + '-2'),
          controller: PageController(
            viewportFraction: 0.85,
          ),
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
