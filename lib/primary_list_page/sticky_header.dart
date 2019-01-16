import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

// ref: https://medium.com/flutter-io/slivers-demystified-6ff68ab0296f
// ref: https://github.com/letsar/flutter_sticky_header
// ref: https://stackoverflow.com/a/50888957/1402287

SliverStickyHeader makeListWithStickyHeader(String headerTitle,
    int itemCount) {
  Widget makeListTile(String title) =>
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1.0, color: Colors.blueGrey))),
          child: Icon(Icons.autorenew, color: Colors.blueGrey),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
      );

  return SliverStickyHeader(
    header: Container(
      height: 60.0,
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        headerTitle,
        style: const TextStyle(color: Colors.red),
      ),
    ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate((context, i) =>
          Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: makeListTile('tile #$i'),
            ),
          ),
        childCount: itemCount,
      ),
    ),
  );
}
