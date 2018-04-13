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

class NewsSnapshot {

    String uniqueKey;
    String title;
    String author;
    String date;
    String jumpUrl;
    List<String> images;


    NewsSnapshot({
        this.uniqueKey,
        this.title,
        this.author,
        this.date,
        this.jumpUrl,
        this.images
    });
}
