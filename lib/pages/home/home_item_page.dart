import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fly/db/article_db.dart';
import 'package:flutter_fly/entry/article_info.dart';
import 'package:flutter_fly/pages/home/view_page.dart';
import 'package:flutter_fly/widgets/fluid_nav_bar/custom_web_view.dart';

class HomeItemPage extends StatefulWidget {
  const HomeItemPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ArticleInfo> _newList = [];
  List<ArticleInfo> _technologyList = [];
  var _bannerList = [];
  final _newsKey = const PageStorageKey('news');
  final _technologyKey = const PageStorageKey('technology');

  @override
  void initState() {
    _loadData();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  _loadData() async {
    await _loadLocalBannerData();
    await _loadLocalArticleData();
    // await _loadRemoteData();
  }

  _loadLocalBannerData() async {
    var jsonStr = await DefaultAssetBundle.of(context)
        .loadString('assets/json/banner.json');
    _bannerList = json.decode(jsonStr);
    setState(() {});
  }

  _loadLocalArticleData() async {
    await ArticleDb().initDb();
    var list = await ArticleDb().findAll();
    if (list != null && list.length > 0) {
      _newList = list.where((f) {
        return f.type == ArticleType.news;
      }).toList();
      _technologyList = list.where((f) {
        return f.type == ArticleType.technology;
      }).toList();
      setState(() {});
    } else {
      var newJson = await DefaultAssetBundle.of(context)
          .loadString('assets/json/news.json');
      List<dynamic> newsData = json.decode(newJson);
      newsData.forEach((f) {
        _newList.add(ArticleInfo(
            title: f['title'],
            url: f['url'],
            author: f['author'],
            type: ArticleType.news));
      });

      var technologyJson = await DefaultAssetBundle.of(context)
          .loadString('assets/json/technology.json');
      List<dynamic> technologyData = json.decode(technologyJson);
      technologyData.forEach((f) {
        _technologyList.add(ArticleInfo(
            title: f['title'],
            url: f['url'],
            author: f['author'],
            type: ArticleType.technology));
      });
      _sortData();
      _saveData(_newList);
      _saveData(_technologyList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, bool) {
        return [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 230,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ViewPage(_bannerList),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this._tabController,
                tabs: const <Widget> [
                  Tab(text: '资讯',),
                  Tab(text: '技术',)
                ],
              ),
            ),
          ),
        ];
      }, body: TabBarView(
      controller: _tabController,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () async {
            print(('onRefresh'));
          },
          child: _buildTabNewsList(_newsKey, _newList),
        ),

        _buildTabNewsList(_technologyKey, _technologyList),
      ],
    ),
    );
  }

  void _sortData() {
    _newList.sort((a, b) {
      return b.time!.compareTo(a.time!);
    });
    _technologyList.sort((a, b) {
      return b.time!.compareTo(a.time!);
    });
    setState(() {});
  }

  _buildTabNewsList(Key newsKey, List<ArticleInfo> list) {
    return ListView.separated(
      key: _newsKey,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(list[index].title!),
          subtitle: Text('作者: ${list[index].author}'),
          onTap: () {
            toWebView(context, list[index].title!, list[index].url!);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 8,
        );
      },
      itemCount: list.length,
    );
  }

  void _saveData(List<ArticleInfo> list) async{
    if (list.isEmpty) {
      return ;
    }
    await ArticleDb().initDb();
    await ArticleDb().save(list);
  }
}


class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: child,
      );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}