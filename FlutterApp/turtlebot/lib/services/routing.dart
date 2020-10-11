import 'package:flutter/material.dart';
import 'package:turtlebot/pages/locations.dart';
import 'package:turtlebot/pages/login.dart';
import 'package:turtlebot/pages/pages_control/robo_commands.dart';
import 'package:turtlebot/pages/pages_control/robo_man_control.dart';
import 'package:turtlebot/pages/pages_control/robo_status.dart';
import 'package:turtlebot/pages/robos.dart';
import 'package:turtlebot/pages/rooms.dart';
import 'package:turtlebot/pages/friends.dart';
import 'package:turtlebot/main.dart';
import 'package:turtlebot/pages/messages.dart';

class RouteGenerator {

  _RouteGenerator() {}

  static const String RouteRoboStatus = '/roboStatus';
  static const String RouteRoboCommands = '/roboCommands';
  static const String RouteManualControl = '/manControl';
  static const String RouteHome = '/';
  static const String RouteLogin = '/login';
  static const String RouteLocations = '/locations';
  static const String RouteRooms = '/rooms';
  static const String RouteRobos = '/robos';
  static const String RouteFriends = '/friends';
  static const String RouteMessages = '/messages';






  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case RouteRobos:
        return MaterialPageRoute(builder: (_) => Robos());
      case RouteFriends:
        return MaterialPageRoute(builder: (_) => Friends());
      case RouteRooms:
        return MaterialPageRoute(builder: (_) => Rooms());
      case RouteMessages:
        return MaterialPageRoute(builder: (_) => Messages());
      case RouteRoboStatus:
        return MaterialPageRoute(builder: (_) => RoboStatus());
      case RouteRoboCommands:
        return MaterialPageRoute(builder: (_) => RoboCommands());
      case RouteManualControl:
        return MaterialPageRoute(builder: (_) => RoboManControl());
      case RouteLogin:
      return MaterialPageRoute(builder: (_) => Login());
      case RouteLocations:
        return MaterialPageRoute(builder: (_) => Locations());
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static onTapToHome(BuildContext context)
  {
    Navigator.pushNamed(context,RouteGenerator.RouteHome);
  }

  static onTapToRoboStatus(BuildContext context)
  {
    Navigator.pushNamed(context,RouteGenerator.RouteRoboStatus);
  }

  static onTapToRoboCommands(BuildContext context)
  {
    Navigator.pushNamed(context,RouteGenerator.RouteRoboCommands);
  }

  static onTapToRoboManControl(BuildContext context)
  {
    Navigator.pushNamed(context,RouteGenerator.RouteManualControl);
  }

  static onTapToLocations(BuildContext context)
  {
    Navigator.pushNamed(context,RouteGenerator.RouteLocations);
  }

  static onTapToRooms(BuildContext context)
  {
    Navigator.pushNamed(context,RouteGenerator.RouteRooms);
  }
}
