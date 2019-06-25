import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'friends_vo.dart';

class FriendsSiderList extends StatefulWidget {
  final List<FriendsVO> items;
  final IndexedWidgetBuilder headerBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder sectionBuilder;

  FriendsSiderList(
      {Key key,
      @required this.items,
      this.headerBuilder,
      @required this.itemBuilder,
      @required this.sectionBuilder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FriendsSiderListState();
}

class _FriendsSiderListState extends State<FriendsSiderList> {
  final ScrollController _scrollController = ScrollController();

  bool _onNotification(ScrollNotification notification) {
    return true;
  }

  Widget _headerView(index) {
    if (index == 0) {
      return Offstage(
        offstage: false,
        child: widget.headerBuilder(context, index),
      );
    }
    return Container();
  }

  bool _shouldShowHeader(int position) {
    if (position <= 0) {
      return true;
    }
    if (widget.items[position].sectionKey !=
        widget.items[position - 1].sectionKey) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NotificationListener(
            onNotification: _onNotification,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      _headerView(index),
                      Offstage(
                        offstage: !_shouldShowHeader(index),
                        child: widget.sectionBuilder(context, index),
                      ),
                      Column(
                        children: <Widget>[
                          widget.itemBuilder(context, index),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
