import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fly/pages/home/home_item_page.dart';
import 'package:flutter_fly/pages/my/my_page.dart';
import 'package:flutter_fly/pages/search/search_page.dart';
import 'package:flutter_fly/pages/widgets_item/widget_page.dart';
import 'package:flutter_fly/upgrade/flutter_app_upgrade.dart';
import 'package:flutter_fly/widgets/fluid_nav_bar/fluid_nav_bar.dart';

import '../../http/http_factory.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currIndex = 0;
  late AppBar _appBar;
  final AppBar _defaultAppBar = AppBar(
    title: const Text('Flutter Fly'),
    centerTitle: true,
    elevation: 0,
  );

  @override
  void initState() {
    super.initState();
    _appBar = _defaultAppBar;
    AppUpgrade.appUpgrade(context, _checkAppInfo(true),
        okBackgroundColors: [const Color(0xFF5DC782), const Color(0xFF5DC782)],
        progressBarColor: const Color(0xFF5DC782).withOpacity(.5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: IndexedStack(
        index: _currIndex,
        children: <Widget>[
          HomeItemPage(),
          WidgetPage(),
          MyPage(),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  ///
  /// 底部导航
  ///
  Widget _buildBottomNavigationBar(BuildContext context) {
    return FluidNavBar(
      icons: const <Widget>[
        Icon(Icons.bookmark_border),
        Icon(Icons.apps),
        Icon(Icons.perm_identity),
      ],
      activeIcons: [
        Icon(
          Icons.bookmark_border,
          color: Theme.of(context).accentColor,
        ),
        Icon(
          Icons.apps,
          color: Theme.of(context).accentColor,
        ),
        Icon(
          Icons.person,
          color: Theme.of(context).accentColor,
        ),
      ],
      titles: const <Widget>[
        Text('首页'),
        Text('控件'),
        Text('我的'),
      ],
      onChange: _navBarOnchange,
    );
  }

  void _navBarOnchange(int index) {
    HapticFeedback.lightImpact();
    _currIndex = index;
    if (_currIndex == 1) {
      _appBar = getWidgetAppBar();
    } else {
      _appBar = _defaultAppBar;
    }
    setState(() {});
  }

  AppBar getWidgetAppBar() {
    return AppBar(
      title: InkWell(
        onTap: () {
          showSearch(context: context, delegate: WidgetSearchDelegate());
        },
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  Future<AppUpgradeInfo> _checkAppInfo(bool isUpgrade) async {
    if (isUpgrade) {
      var updateInfo = await HttpFactory().getUpgradeInfo();
      if (updateInfo.isEmpty) {
        return Future.value(AppUpgradeInfo(title: '升级', contents: ['暂无升级版本']));
      }
      var appInfo = await FlutterUpgrade.appInfo;
      if (updateInfo['version'] != appInfo.versionName) {
        return Future.value(AppUpgradeInfo(
          title: updateInfo['title'],
          contents: (updateInfo['content'] as String).split('\r\n'),
          apkDownloadUrl: updateInfo['apkDownloadUrl'],
          force: updateInfo['force'],
        ));
      }

      return Future.value(null);
    } else {
      return Future.value(null);
    }
  }
}
