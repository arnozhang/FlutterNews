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
import 'package:flutter_news/homepage/news_card.dart';
import 'package:flutter_news/loader/news_loader.dart';
import 'package:flutter_news/loader/news_snapshot.dart';
import 'package:flutter_news/utils/news_detail_page.dart';
import 'package:flutter_news/utils/strings.dart';


class NewsPage extends StatefulWidget {

    final String tabName;

    NewsPage(this.tabName);

    @override
    State<StatefulWidget> createState() {
        return _NewsPageState();
    }
}


class _NewsPageState extends State<NewsPage>
    implements LoaderStateChangedCallback {

    NewsLoader newsLoader;


    @override
    void initState() {
        super.initState();

        newsLoader = NewsLoader(widget.tabName, this);
        newsLoader.loadNews();
    }

    @override
    Widget build(BuildContext context) {
        if (newsLoader.loadState == NewsLoadState.Loading) {
            return _generateLoadingPage();
        } else if (newsLoader.loadState == NewsLoadState.Error) {
            return _generateErrorPage();
        }

        if (newsLoader.isEmpty()) {
            return _generateEmptyPage();
        }

        return _generateNewsListPage();
    }

    Widget _generateNewsListPage() {
        return ListView.builder(
            itemCount: newsLoader.newsCount(),
            itemBuilder: _generateListItem);
    }

    Widget _generateErrorPage() {
        var error = NewsStrings.LOAD_ERROR_TIPS;
        if (newsLoader.lastLoadReason != null &&
            newsLoader.lastLoadReason.isNotEmpty) {
            error += ' - ${newsLoader.lastLoadReason}';
        }

        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Icon(Icons.error, color: Colors.redAccent, size: 50.0,),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 80.0),
                        child: Text(error,
                            style: TextStyle(color: Color(0xff333333)),),)
                ],
            ),
        );
    }

    Widget _generateEmptyPage() {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Icon(Icons.library_books, color: Colors.greenAccent,
                        size: 50.0,),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 80.0),
                        child: Text(NewsStrings.LOAD_EMPTY_TIPS,
                            style: TextStyle(color: Color(0xff333333)),),)
                ],
            ),
        );
    }

    Widget _generateLoadingPage() {
        return Center(
            child: CircularProgressIndicator(),
        );
    }

    Widget _generateListItem(BuildContext context, int index) {
        final snapshot = newsLoader.getNewsSnapshot(index);
        return GestureDetector(
            onTap: () => _openNewsDetailPage(snapshot),
            child: NewsCard(snapshot),);
    }

    _openNewsDetailPage(NewsSnapshot snapshot) {
        NewsDetailPage.open(context, snapshot.title, snapshot.jumpUrl);
    }

    @override
    void onLoaderStateChanged(NewsLoadState state) {
        print('News state changed! Tab = ${widget.tabName}, state = ${state
            .toString()}');

        setState(() => {});
    }
}
