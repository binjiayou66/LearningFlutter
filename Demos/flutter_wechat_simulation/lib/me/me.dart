import 'package:flutter/material.dart';
import 'me_item.dart';
import '../common/touch_callback.dart';

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0),
            color: Colors.white,
            height: 80.0,
            child: TouchCallback(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 12.0, right: 15.0),
                    child: Image.asset('assets/header01.jpg',
                        width: 70.0, height: 70.0),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('安歌',
                            style: TextStyle(
                                fontSize: 18.0, color: Color(0xff353535))),
                        Text('账号 andy666',
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xffa9a9a9)))
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: MeItem(
              title: '好友动态',
              icon: Icon(Icons.toc),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                MeItem(
                  title: '消息管理',
                  icon: Icon(Icons.toc),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
                MeItem(
                  title: '消息管理',
                  icon: Icon(Icons.toc),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
                MeItem(
                  title: '我的相册',
                  icon: Icon(Icons.toc),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
                MeItem(
                  title: '我的文件',
                  icon: Icon(Icons.toc),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: MeItem(
              title: '清理缓存',
              icon: Icon(Icons.toc),
            ),
          ),
        ],
      ),
    );
  }
}
