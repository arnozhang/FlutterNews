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
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class NewsDetailPage extends StatelessWidget {

    static open(BuildContext context, String title, String url) {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => NewsDetailPage(title, url)));
    }


    final String title;
    final String url;

    NewsDetailPage(this.title, this.url);


    @override
    Widget build(BuildContext context) {
        print('Will load url: $url');

        return WebviewScaffold(
            url: url,
            appBar: AppBar(title: Text(title)),
            withJavascript: true,
            withZoom: false,
            withLocalStorage: true,
        );
    }
}