import 'package:flutter/material.dart';
import 'package:turtlebot/services/routing.dart';

class AppNavBarController extends StatefulWidget {
  @override
  _AppNavBarControllerState createState() => _AppNavBarControllerState();
}

class _AppNavBarControllerState extends State<AppNavBarController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ButtonTheme(
                minWidth: 300,
                height: 100,
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.RouteRobos);
                  },
                  icon: Icon(Icons.mood),
                  label: Text('Robos'),
                  color: Colors.blue,
                ),
              ),
              ButtonTheme(
                minWidth: 300,
                height: 100,
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.RouteFriends);
                  },
                  icon: Icon(Icons.perm_contact_calendar),
                  label: Text('Friends'),
                  color: Colors.red,
                ),
              ),
              ButtonTheme(
                minWidth: 200,
                height: 100,
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.RouteRooms);
                  },
                  icon: Icon(Icons.location_on),
                  label: Text('Rooms'),
                  color: Colors.green,
                ),
              ),
              ButtonTheme(
                minWidth: 200,
                height: 100,
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.RouteMessages);
                  },
                  icon: Icon(Icons.mail),
                  label: Text('Message'),
                  color: Colors.orange,
                ),
              ),
              ButtonTheme(
                minWidth: 200,
                height: 100,
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteGenerator.RouteRoboStatus);
                  },
                  icon: Icon(Icons.videogame_asset),
                  label: Text('Control'),
                  color: Colors.purple,
                ),
              )
            ]));
  }
}
