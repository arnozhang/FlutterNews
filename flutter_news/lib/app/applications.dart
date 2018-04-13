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
import 'package:flutter_news/homepage/homepage.dart';
import 'package:flutter_news/utils/strings.dart';


class NewsApplication extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: NewsStrings.APP_NAME,
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: NewsHomePage(title: NewsStrings.APP_NAME),
        );
    }
}
