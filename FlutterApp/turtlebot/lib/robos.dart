import 'package:flutter/material.dart';

import 'navigation.dart';

class Robos extends StatefulWidget {
  Robos({Key key}) : super(key: key);

  @override
  _RobosState createState() {
    return _RobosState();
  }
}

class _RobosState extends State<Robos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connected Robos"),
      ),
      body: Center(child: Text('Robo Control')),
    );
  }
}
