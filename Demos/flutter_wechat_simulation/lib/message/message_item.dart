import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'message_data.dart';
import 'package:flutter_wechat_simulation/common/touch_callback.dart';

class MessageItem extends StatelessWidget {
  final MessageData message;
  MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xffd9d9d9))),
      ),
      height: 64.0,
      child: TouchCallback(
        onPressed: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 13.0, right: 13.0),
              child: Image.network(message.avatar, width: 48.0, height: 48.0),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.title,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      message.subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(right: 12.0, top: 12.0),
              child: Text(
                formatDate(message.time, [HH, ':', nn, ':', ss]).toString(),
                style: TextStyle(fontSize: 14.0, color: Color(0xffa9a9a9)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
