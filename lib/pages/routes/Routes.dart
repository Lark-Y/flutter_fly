
import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/home/home_page.dart';
import 'package:flutter_fly/pages/my/about_page.dart';
import 'package:flutter_fly/pages/my/browse_page.dart';
import 'package:flutter_fly/pages/my/collections_page.dart';
import 'package:flutter_fly/pages/my/my_detail_page.dart';

class Routes {
  static const String welcome_page = '/';
  static const String home_page = 'home';
  static const String about_page = 'about';
  static const String collections_page = 'collections';
  static const String browse_page = 'browse';
  static const String my_detail_page = 'my_detail';

  static Map<String, WidgetBuilder> routes = {
    home_page: (context) => HomePage(),
    my_detail_page: (context) => MyDetailPage(),
    collections_page: (context) => CollectionPage(),
    browse_page: (context) => BrowsePage(),
    about_page: (context) => AboutPage(),

  };
}