import 'package:flutter/material.dart';
import 'package:turtlebot/routing.dart';
import 'package:turtlebot/robos.dart';
import 'package:turtlebot/rooms.dart';

import 'control.dart';
import 'friends.dart';
import 'messages.dart';
import 'navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurtleBot',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turtlebot Control App"),
        backgroundColor: Colors.grey,
      ),
      body: AppNavBarController(),
    );
  }
}
