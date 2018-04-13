//
// FlutterNews project.
//
// Copyright 2018 Arno Zhang <zyfgood12@163.com>
//
// Licensed under the MIT License;
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/loader/news_snapshot.dart';


class NewsCard extends StatefulWidget {

    final NewsSnapshot snapshot;

    NewsCard(this.snapshot);


    @override
    State<StatefulWidget> createState() {
        return _NewsCardState();
    }
}


class _NewsCardState extends State<NewsCard> {

    @override
    Widget build(BuildContext context) {
        final snapshot = widget.snapshot;

        final children = <Widget>[
            Text(snapshot.title, style: TextStyle(
                fontSize: 17.0, fontWeight: FontWeight.w500))
        ];

        var images = _buildImages(snapshot.images);
        if (images != null) {
            children.add(images);
        }

        children.add(Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 15.0),
            child: Text('${snapshot.author} - ${snapshot.date}',
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12.0, color: Color(0xffaaaaaa)),),));

        return Card(child: Container(
            padding: EdgeInsets.only(
                top: 20.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: Column(children: children,),
        ),);
    }

    Widget _buildImages(List<String> images) {
        if (images == null || images.isEmpty) {
            return null;
        }

        var height = 100.0;
        return Row(
            children: images.map((url) {
                return Expanded(child: Container(
                    margin: EdgeInsets.only(
                        top: 15.0, left: 5.0, right: 5.0),
                    child: CachedNetworkImage(imageUrl: url, height: height, fit: BoxFit.cover,),
                ));
            }).toList(),);
    }
}