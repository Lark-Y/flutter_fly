import 'package:flutter/material.dart';
import 'package:flutter_fly/db/browse_db.dart';
import 'package:flutter_fly/widgets/fluid_nav_bar/custom_web_view.dart';

///
/// 浏览
///
class BrowsePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BrowsePage();
}

class _BrowsePage extends State<BrowsePage> {
  List<Map<String, dynamic>> _list = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async{
    await BrowseDb().initDb();
    _list = await BrowseDb().findAll();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('浏览记录'),),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_list[index]['title']}'),
            onTap: () {
              toWebView(context, _list[index]['title'], _list[index]['url']);
            },
          );
        }, separatorBuilder: (context, index) {
          return const Divider(height: 1,);
      },
        itemCount: _list.length,
      ),
    );
  }
}
