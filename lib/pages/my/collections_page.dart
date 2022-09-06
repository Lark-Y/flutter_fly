

import 'package:flutter/material.dart';
import 'package:flutter_fly/db/collection_db.dart';
import 'package:flutter_fly/entry/collection_info.dart';
import 'package:flutter_fly/widgets/fluid_nav_bar/custom_web_view.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionPage();
}

class _CollectionPage extends State<CollectionPage>{

  List<CollectionInfo> _list = [];

  @override
  void initState() {
    _loadData();
  }

  void _loadData() async{
    await CollectionDb().initDb();
    _list = await CollectionDb().findAll();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_list[index].title}'),
            onTap: () {
              toWebView(context, _list[index].title!, _list[index].url!);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 1,);
        },
        itemCount: _list.length,
      ),
    );
  }
}