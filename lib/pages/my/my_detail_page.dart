

import 'package:flutter/material.dart';

class MyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context ) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('详细信息'),
         elevation: 0,
       ),
       body: _buildBody(context),
     );
  }

  _buildBody(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          _buildItem('微信号', 'wx666666', (){}),
          const SizedBox(
            height: 1,
          ),
          _buildItem('公众号', 'Java程序猿', (){}),
          const SizedBox(
            height: 1,
          ),
          _buildItem('博客', 'https://www.weibo.com', (){})
        ],
      ),
    );
  }

  _buildItem(String title, String content, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              content,
              style: TextStyle(color: const Color(0xFF727272)),
            )
          ],
        ),
      ),
    );
  }



}