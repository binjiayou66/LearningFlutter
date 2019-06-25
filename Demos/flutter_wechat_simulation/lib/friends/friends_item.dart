import 'package:flutter/material.dart';
import 'friends_vo.dart';

class FriendsItem extends StatelessWidget {
  final FriendsVO item;

  FriendsItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xffd9d9d9))),
      ),
      height: 52.0,
      child: FlatButton(
        onPressed: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              item.avatarURL,
              width: 36.0,
              height: 36.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 12.0),
              child: Text(
                item.name,
                style: TextStyle(fontSize: 18.0, color: Color(0xff353535)),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
