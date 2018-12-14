import 'dart:math';

import 'package:flutter/cupertino.dart';

class StickyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
        delegate: MyPersistentHeaderDelegate(
          collapsedHeight: 0.0,
          expandedHeight: 30.0,
        ),
    );
  }
}

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {

  MyPersistentHeaderDelegate({
    @required this.collapsedHeight,
    @required this.expandedHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      height: expandedHeight,
        color: Color(0xff80deea),
        child: new Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
          child: new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("Time"), new Text("Price"), new Text("Hotness")
            ],
          ),
        )
    );
  }

  final double expandedHeight;
  final double collapsedHeight;

  @override double get minExtent => collapsedHeight;
  @override double get maxExtent => max(expandedHeight, minExtent);

  @override
  bool shouldRebuild(MyPersistentHeaderDelegate oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight
        || collapsedHeight != oldDelegate.collapsedHeight;
  }

}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override double get minExtent => minHeight;
  @override double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight
        || minHeight != oldDelegate.minHeight
        || child != oldDelegate.child;
  }

  @override
  String toString() => '_SliverAppBarDelegate';
}
