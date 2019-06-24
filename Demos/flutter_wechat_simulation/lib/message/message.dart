import 'package:flutter/material.dart';
import 'message_data.dart';
import 'message_item.dart';

class Message extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<MessageData> messages = [
    MessageData(
        'https://cdn.duitang.com/uploads/item/201410/26/20141026191422_yEKyd.thumb.700_0.jpeg',
        '阿喵',
        '今天想吃小鱼干',
        DateTime.now(),
        MessageType.Chat),
    MessageData(
        'https://img4.duitang.com/uploads/blog/201507/10/20150710083357_udQFz.jpeg',
        '皮卡丘',
        '皮卡皮卡',
        DateTime.now(),
        MessageType.Chat),
    MessageData(
        'https://cdn.duitang.com/uploads/blog/201404/22/20140422142715_8GtUk.thumb.600_0.jpeg',
        '绿茶',
        '我想给全世界的男人幸福呢',
        DateTime.now(),
        MessageType.Chat),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return MessageItem(messages[index]);
        },
      ),
    );
  }
}
