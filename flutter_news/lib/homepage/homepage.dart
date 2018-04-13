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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/homepage/news_page.dart';
import 'package:flutter_news/utils/strings.dart';


class NewsHomePage extends StatefulWidget {

    final String title;

    NewsHomePage({Key key, this.title}) : super(key: key);

    @override
    _NewsHomePageState createState() => _NewsHomePageState();
}


class _NewsHomePageState extends State<NewsHomePage> {

    @override
    Widget build(BuildContext context) {
        final tabs = new List<Tab>();
        NewsStrings.TAB_NAMES.forEach((tab) =>
            tabs.add(Tab(
                child: Text(tab, style: new TextStyle(fontSize: 20.0))
            ))
        );

        return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
                appBar: AppBar(
                    title: Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Icon(
                                Icons.camera, color: Colors.pink[300],),),
                        Text(widget.title,
                            style: TextStyle(fontWeight: FontWeight.bold),)
                    ],),
                    bottom: TabBar(tabs: tabs, isScrollable: true),
                ),
                drawer: createDrawer(),
                body: TabBarView(
                    children: NewsStrings.TAB_NAMES.map((tab) =>
                        Center(child: NewsPage(tab))
                    ).toList())
            ));
    }

    createDrawer() {
        return Drawer(child: ListView(children: <Widget>[
            Column(children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: CircleAvatar(radius: 40.0,
                                backgroundImage: AssetImage(
                                    'assets/images/naga.png'))
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text('牧秦丶', style: TextStyle(
                                fontSize: 22.0,  color: Colors.white),),
                        )
                    ]))
            ],),
            ListTile(title: Text(
                'About FlutterNews', style: TextStyle(fontSize: 16.0)),
                onTap: () {},)
        ],));
    }
}
