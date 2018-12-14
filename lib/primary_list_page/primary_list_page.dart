import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/page_transformer/page_transformer.dart';
import 'package:kidspend3/page_transformer/page_transformer_item.dart';
import 'package:kidspend3/primary_list_page/disappearing_space_bar_title.dart';
import 'package:kidspend3/scenes.dart';

class PrimaryListPage extends StatelessWidget {

  final SceneList sceneList;

  PrimaryListPage({
    this.sceneList,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
                    fontSize: 22.0,
                  ),
                ),
              ),
              background: BackgroundPageTransformer(
                sceneList: sceneList,
              ),
            ),
          ),
          SliverList(
            delegate: new SliverChildListDelegate(
              List.generate(50, (index) =>
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
