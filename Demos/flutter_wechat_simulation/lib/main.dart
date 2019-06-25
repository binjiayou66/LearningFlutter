import 'package:flutter/material.dart';
import './common/webview.dart';
import 'app.dart';
import 'loading.dart';
import 'search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '聊天室',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Color(0xffebebeb),
        cardColor: Colors.green,
      ),
      routes: <String, WidgetBuilder>{
        'app': (BuildContext context) => App(),
        '/friends': (BuildContext context) => WebViewPage(
              url: 'https://www.baidu.com',
            ),
        'search': (BuildContext context) => Search(),
      },
      home: Loading(),
    );
  }
}
