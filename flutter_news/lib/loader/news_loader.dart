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

import 'dart:convert';

import 'package:flutter_news/loader/news_snapshot.dart';
import 'package:http/http.dart';


enum NewsLoadState {
    Loading,
    Error,
    Complete
}


abstract class LoaderStateChangedCallback {

    void onLoaderStateChanged(NewsLoadState state);
}


class NewsLoader {

    static const API_KEY = '';


    String newsCategory;
    String newsUrl;
    String lastLoadReason;

    NewsLoadState loadState = NewsLoadState.Loading;
    LoaderStateChangedCallback stateChangedCallback;
    List<NewsSnapshot> newsSnapshots = [];


    NewsLoader(this.newsCategory, this.stateChangedCallback) {
        print('New loader: $newsCategory');

        newsUrl = 'http://v.juhe.cn/toutiao/index?type=${this
            .newsCategory}&key=${NewsLoader.API_KEY}';
    }

    loadNews() async {
        print('Will load news: $newsCategory');

        newsSnapshots.clear();
        this.loadState = NewsLoadState.Loading;
        _notifyLoadStateChanged();

        Response response = await get(newsUrl);
        var map = json.decode(response.body);

        lastLoadReason = map['reason'];
        var result = map['result'];
        var stat = result['stat'];
        if (stat == null || "1".compareTo(stat) != 0) {
            print('Load news of $newsCategory FAILED! stat = $stat');

            loadState = NewsLoadState.Error;
            _notifyLoadStateChanged();
            return;
        }

        List data = result['data'];
        if (data != null && data.isNotEmpty) {
            data.forEach((item) =>
                newsSnapshots.add(NewsSnapshot(
                    uniqueKey: item['uniquekey'],
                    title: item['title'],
                    date: item['date'],
                    author: item['author_name'],
                    jumpUrl: item['url'],
                    images: _parseImages(item)
                )));
        }

        loadState = NewsLoadState.Complete;
        _notifyLoadStateChanged();
    }

    void reset() {
        newsSnapshots.clear();
        loadState = NewsLoadState.Complete;
        _notifyLoadStateChanged();
    }

    _notifyLoadStateChanged() {
        stateChangedCallback.onLoaderStateChanged(loadState);
    }

    getNewsSnapshot(int position) {
        if (position >= 0 && position < newsSnapshots.length) {
            return newsSnapshots[position];
        }

        return null;
    }

    newsCount() => newsSnapshots.length;

    isEmpty() => newsSnapshots.isEmpty;

    isNotEmpty() => newsSnapshots.isNotEmpty;

    _parseImages(item) {
        List<String> images = [];
        var add = (key) {
            String image = item[key];
            if (image != null && image.isNotEmpty) {
                images.add(image);
            }
        };

        add('thumbnail_pic_s');
        add('thumbnail_pic_s02');
        add('thumbnail_pic_s03');

        return images;
    }
}
