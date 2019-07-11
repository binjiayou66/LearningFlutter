import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/browser_page.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> titles = ['选择照片', '预览'];

  final List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片浏览'),
      ),
      body: ListView.builder(
        itemCount: titles.length + 1,
        itemBuilder: (context, index) {
          if (index == titles.length) {
            return Container(
              child: images.length > 0
                  ? Wrap(
                      children: <Widget>[
                        for (var image in images)
                          Image.file(
                            image,
                            width: 80,
                            height: 80,
                          ),
                      ],
                    )
                  : Text('请先选择图片'),
            );
          }
          return Container(
            child: RaisedButton(
              onPressed: () async {
                switch (index) {
                  case 0:
                    {
                      final image = await ImagePicker.pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1024,
                          maxHeight: 1024);
                      setState(() {
                        images.add(image);
                      });
                    }
                    break;
                  case 1:
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrowserPage()));
                    }
                    break;
                  default:
                }
              },
              child: Text(titles[index]),
            ),
          );
        },
      ),
    );
  }
}
