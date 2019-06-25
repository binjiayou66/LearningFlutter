import 'package:flutter/material.dart';
import '../common/touch_callback.dart';

class MeItem extends StatelessWidget {
  final Icon icon;
  final String title;

  MeItem({@required this.icon, @required this.title});

  @override
  Widget build(BuildContext context) {
    return TouchCallback(
      onPressed: () {
        switch (title) {
          case '好友动态':
            Navigator.pushNamed(context, '/friends');
            break;
          default:
        }
      },
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 22.0, right: 22.0),
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: icon,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16.0, color: Color(0xff353535)),
            ),
          ],
        ),
      ),
    );
  }
}
