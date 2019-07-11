import 'package:flutter/material.dart';

class ImageBrowser extends StatelessWidget {
  final int imageCount;
  final Image Function(int index) imageProvider;

  ImageBrowser(this.imageCount, this.imageProvider, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        children: <Widget>[
          for (int i = 0; i < imageCount; i++) imageProvider(i),
        ],
      ),
    );
  }
}
