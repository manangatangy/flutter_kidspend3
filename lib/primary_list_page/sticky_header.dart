import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

// ref: https://medium.com/flutter-io/slivers-demystified-6ff68ab0296f
// ref: https://github.com/letsar/flutter_sticky_header
// ref: https://stackoverflow.com/a/50888957/1402287

SliverStickyHeader makeListWithStickHeader(
    String title,
    int count) {
  return SliverStickyHeader(
    header: Container(
      height: 60.0,
      color: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate((context, i) =>
          ListTile(
          leading: CircleAvatar(
            child: Text('0'),
          ),
          title: Text('List tile #$i'),
        ),
        childCount: count,
      ),
    ),
  );
}
