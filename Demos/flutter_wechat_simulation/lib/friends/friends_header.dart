import 'package:flutter/material.dart';
import 'friends_item.dart';
import 'friends_vo.dart';

class FriendsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FriendsItem(FriendsVO('', '新加好友', 'assets/header01.jpg')),
        FriendsItem(FriendsVO('', '公共聊天室', 'assets/header02.jpg')),
      ],
    );
  }
}
