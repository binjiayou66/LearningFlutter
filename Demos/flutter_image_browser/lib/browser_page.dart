import 'package:flutter/material.dart';
import 'package:flutter_image_browser/image_browser.dart';

class BrowserPage extends StatelessWidget {
  final imgUrlList = [
    'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg',
    'https://ws1.sinaimg.cn/large/0065oQSqly1fw8wzdua6rj30sg0yc7gp.jpg',
    'https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg',
    'https://ws1.sinaimg.cn/large/0065oQSqly1fuo54a6p0uj30sg0zdqnf.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browser'),
      ),
      body:
          ImageBrowser(imgUrlList.length, (i) => Image.network(imgUrlList[i])),
    );
  }
}
