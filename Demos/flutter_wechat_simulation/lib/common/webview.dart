import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final url;

  WebViewPage({Key key, this.url}) : super(key: key);

  _WebViewPageState createState() => _WebViewPageState(url);
}

class _WebViewPageState extends State<WebViewPage> {
  final _key = UniqueKey();
  var _url;

  _WebViewPageState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,
            ),
          )
        ],
      ),
    );
  }
}
