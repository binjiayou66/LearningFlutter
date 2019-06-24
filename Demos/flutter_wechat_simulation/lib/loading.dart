import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('app');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/loading.jpg', fit: BoxFit.contain),
    );
  }
}
