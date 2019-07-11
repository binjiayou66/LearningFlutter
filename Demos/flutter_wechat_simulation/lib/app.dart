import 'package:flutter/material.dart';
import 'message/message.dart';
import 'friends/friends.dart';
import 'me/me.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  var _currentIndex = 0;
  Message message;
  Friends friends;
  Me me;

  currentPage() {
    switch (_currentIndex) {
      case 0:
        {
          if (message == null) {
            message = Message();
          }
          return message;
        }
      case 1:
        {
          if (friends == null) {
            friends = Friends();
          }
          return friends;
        }
      case 2:
        {
          if (me == null) {
            me = Me();
          }
          return me;
        }
      default:
    }
  }

  _popupMenuItem(String title, {String imagePath}) {
    return PopupMenuItem(
      child: GestureDetector(
        onTapUp: (_) async {
          String content = await BarcodeScanner.scan();
          print('aaa   $content');
        },
        child: Row(
          children: <Widget>[
            Image.asset(imagePath, width: 32.0, height: 32.0),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(title, style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  _bottomNavigationBarItem(int index, String title, String iconName) {
    return BottomNavigationBarItem(
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex == index
                  ? Color(0xff46c01b)
                  : Color(0xff999999)),
        ),
        icon: _currentIndex == index
            ? Image.asset('assets/${iconName}_on.png',
                width: 32.0, height: 28.0)
            : Image.asset('assets/$iconName.png', width: 32.0, height: 28.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IM'),
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.search),
            onTap: () {
              Navigator.pushNamed(context, 'search');
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.add),
              onTap: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(500.0, 76.0, 10.0, 0.0),
                  items: <PopupMenuEntry>[
                    _popupMenuItem('发起会话', imagePath: 'assets/add_chat.png'),
                    _popupMenuItem('添加好友', imagePath: 'assets/add_friend.png'),
                    _popupMenuItem('联系客服', imagePath: 'assets/service.png'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomNavigationBarItem(0, '聊天', 'chat'),
          _bottomNavigationBarItem(1, '好友', 'friends'),
          _bottomNavigationBarItem(2, '我的', 'me'),
        ],
      ),
      body: currentPage(),
    );
  }
}
