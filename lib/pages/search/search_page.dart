import 'package:flutter/material.dart';
import 'package:flutter_fly/db/widget_db.dart';
import 'package:flutter_fly/entry/widget_info.dart';
import 'package:flutter_fly/widgets/fluid_nav_bar/custom_web_view.dart';

class WidgetSearchDelegate extends SearchDelegate<String> {
  WidgetSearchDelegate({this.widgetInfoList}) {
    _initData();
  }

  List<WidgetInfo>? widgetInfoList;

  _initData() async {
    await WidgetDb().initDb();
    List<WidgetInfo> result = await WidgetDb().findAll();
    if (widgetInfoList == null) {
      widgetInfoList = [];
    }
    widgetInfoList!.clear();
    widgetInfoList!.addAll(result);

  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Iterable<WidgetInfo> _list = widgetInfoList!.where((f) {
      return f.title!.toLowerCase().contains(query.toLowerCase());
    });
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${_list.elementAt(index).title}'),
          onTap: () {
            toWebView(context, _list.elementAt(index).title!,
              'http://laomengit.com/${_list.elementAt(index).url}',
              desc: _list.elementAt(index).desc!,
              tags: _list.elementAt(index).tags!
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _list.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (widgetInfoList == null) {
      return Container();
    }
    Iterable<WidgetInfo> _list = widgetInfoList!.where((f) {
      return f.title!.toLowerCase().contains(query.toLowerCase());
    });
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${_list.elementAt(index).title}'),
          onTap: () {
            toWebView(context, _list.elementAt(index).title!,
                'http://laomengit.com/${_list.elementAt(index).url}',
                desc: _list.elementAt(index).desc!,
                tags: _list.elementAt(index).tags!);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _list.length,
    );
  }
}