import 'package:flutter/material.dart';
import 'package:turtlebot/frameworks/custom_navigation_bar/top_app_bar.dart';
import 'package:turtlebot/frameworks/custom_navigation_bar/top_bar_image_icon.dart';
import 'package:turtlebot/services/routing.dart';

class RoboManControl extends StatefulWidget
{
  final String _titleText = "Robo-Manual-Control";
  @override
  State<StatefulWidget> createState() {

    return _RoboManControlState();
  }

}

class _RoboManControlState extends State<RoboManControl>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TopAppBar(
              [TopBarImageIcon(Icon(Icons.format_list_bulleted),RouteGenerator.onTapToRoboStatus),
                TopBarImageIcon(Icon(Icons.computer),RouteGenerator.onTapToRoboCommands),
                TopBarImageIcon(Icon(Icons.games, color: Colors.white),RouteGenerator.onTapToRoboManControl)],
              widget._titleText
          ),
          backgroundColor: Colors.purple,
        ),
      body: Column(
        children: <Widget>[FloatingActionButton(
        onPressed: () {},
    )],
    ),
    );
  }
}