import 'package:flutter/material.dart';
import 'package:flutter_fly/db/browse_db.dart';
import 'package:flutter_fly/db/collection_db.dart';
import 'package:flutter_fly/pages/routes/Routes.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _collectionCount = 0;
  int _browseCount = 0;

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // 作者
          _buildAuthor(context),
          const SizedBox(
            height: 10,
          ),
          // 我的收藏和浏览
          _buildCollectionAndRecord(context),
          const SizedBox(
            height: 10,
          ),
          _buildItem('关于', (){
            Navigator.pushNamed(context, Routes.about_page);
          })
        ],
      ),
    );
  }

  void _loadData() async {
    await CollectionDb().initDb();
    var result = await CollectionDb().findAll();
    await BrowseDb().initDb();
    var result1 = await BrowseDb().findAll();

    setState(() {
      _collectionCount = result.length;
      _browseCount = result1.length;
    });
  }

  _buildAuthor(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.my_detail_page);
      },
      child: Container(
        height: 100,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Container(
          child: Row(
            children: <Widget>[
              //  头像
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/header.png'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(60))),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Java程序员',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '专业跑路',
                      style: TextStyle(color: Color(0xFF727272)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Color(0xFFC9C9C9)),
            ],
          ),
        ),
      ),
    );
  }

  _buildCollectionAndRecord(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildItem('我收藏的文章($_collectionCount)', () {
            Navigator.pushNamed(context, Routes.collections_page);
          }),
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Divider(
              height: 1,
            ),
          ),
          _buildItem('我浏览的文章($_browseCount)', () {
            Navigator.pushNamed(context, Routes.browse_page);
          })
        ],
      ),
    );
  }
  
  _buildItem(String title, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 25, right:15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: const TextStyle(fontSize: 16),),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFC9C9C9)),
          ],
        ),
      ),
    );
  }
}
