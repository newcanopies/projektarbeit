import 'package:flutter/material.dart';
import 'package:turtlebot/objects/data_base_objects.dart';
import 'package:turtlebot/pages/pages_control/controls.dart';
import 'package:turtlebot/pages/robos.dart';
import 'package:turtlebot/pages/rooms.dart';
import 'package:turtlebot/pages/friends.dart';
import 'package:turtlebot/main.dart';
import 'package:turtlebot/pages/messages.dart';
import 'package:turtlebot/pages/locations.dart';
import 'package:turtlebot/pages/login.dart';


class RouteGenerator {
  // _RouteGenerator() {}

  static const String RouteRoboStatus = '/roboStatus';
  static const String RouteHome = '/';
  static const String RouteLogin = '/login';
  static const String RouteLocations = '/locations';
  static const String RouteRooms = '/rooms';
  static const String RouteRobos = '/robos';
  static const String RouteFriends = '/friends';
  static const String RouteMessages = '/messages';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLogin:
        {
          return MaterialPageRoute(builder: (_) => Login());
        }
      case RouteHome:
        {
          return MaterialPageRoute(builder: (_) => Home(settings.arguments));
        }
      case RouteRobos:
        {
          return MaterialPageRoute(builder: (_) => Robos());
        }
      case RouteFriends:
        {
          return MaterialPageRoute(builder: (_) => Friends());
        }
      case RouteRooms:
        {
          return MaterialPageRoute(builder: (_) => Rooms());
        }
      case RouteMessages:
        {
          return MaterialPageRoute(builder: (_) => Messages(settings.arguments));
        }
      case RouteRoboStatus:
        {
          return MaterialPageRoute(builder: (_) => Controls());
        }
      case RouteLocations:
        return MaterialPageRoute(builder: (_) => Locations());

      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static onTapToHome(BuildContext context, {User sessionUser}) {
    Navigator.pushNamed(context, RouteGenerator.RouteHome, arguments: sessionUser);
  }

  static onTapToLogin(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteLogin);
  }

  static onTapToRoboStatus(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteRoboStatus);
  }

  static onTapToLocations(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteLocations);
  }

  static onTapToRooms(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteRooms);
  }

  static onTapToFriends(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteFriends);
  }

  static onTapToMessages(BuildContext context, {User selectedUser}) {
    Navigator.pushNamed(context, RouteGenerator.RouteMessages, arguments: selectedUser);
  }

  static onTapToRobos(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteRobos);
  }
}
