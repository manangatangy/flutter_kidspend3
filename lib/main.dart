import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidspend3/page_transformer/page_transformer.dart';
import 'package:kidspend3/page_transformer/page_transformer_item.dart';
import 'package:kidspend3/scenes.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(),
      home: MainList(
        sceneList: russianSceneList,
      ),
    );
  }
}

class MainList extends StatelessWidget {

  final SceneList sceneList;

  MainList({
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
              title: Text(
                'List of Items',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: BackgroundPageTransformer(
                sceneList: sceneList,
              ),
//              background: Image.asset(
//                imageAssetPaths[1],
//                fit: BoxFit.cover,
//              ),
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
            final pageVisibility = visibilityResolver.resolvePageVisibility(
                index);

            return PageItem(
              sceneData: sceneList.scenes[index],
              pageVisibility: pageVisibility,
            );
          },
        );
      },
      itemCount: sceneList.scenes.length,
    );
  }
}
