import 'package:flutter/material.dart';
import 'friends_sider_list.dart';
import 'friends_vo.dart';
import 'friends_item.dart';
import 'friends_header.dart';

class Friends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<FriendsVO> _data = [
    FriendsVO('A', 'Andy', 'assets/header03.jpg'),
    FriendsVO('B', 'Buddy', 'assets/header04.jpg'),
    FriendsVO('B', 'Borm', 'assets/header05.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FriendsSiderList(
        items: _data,
        headerBuilder: (BuildContext context, int index) {
          return Container(
            child: FriendsHeader(),
          );
        },
        sectionBuilder: (BuildContext context, int index) {
          return Container(
            height: 32.0,
            padding: EdgeInsets.only(left: 14.0),
            color: Colors.grey[300],
            alignment: Alignment.centerLeft,
            child: Text(
              _data[index].sectionKey,
              style: TextStyle(fontSize: 14.0, color: Color(0xff909090)),
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: FriendsItem(_data[index]),
          );
        },
      ),
    );
  }
}
