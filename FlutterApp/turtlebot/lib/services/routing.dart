import 'package:flutter/material.dart';
import 'package:turtlebot/objects/data_base_objects.dart';
import 'package:turtlebot/main.dart';
import 'package:turtlebot/pages/loading_page.dart';
import 'package:turtlebot/pages/login.dart';
import 'package:turtlebot/frameworks/page_frame.dart';


class RouteGenerator {

  static const String RouteHome = '/home';
  static const String RouteLogin = '/login';
  static const String RouteLoading = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLoading:
        {
          return MaterialPageRoute(builder: (_) => LoadingPage());
        }
      case RouteLogin:
        {
          return MaterialPageRoute(builder: (_) => PageFrame(colorTheme: Login.colorTheme, page:Login()));
        }
      case RouteHome:
        {
          return MaterialPageRoute(builder: (_) => Home(settings.arguments));
        }
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static onTapToHome(BuildContext context, {User sessionUser}) {
    Navigator.pushNamed(
        context, RouteGenerator.RouteHome, arguments: sessionUser);
  }

  static onTapToLogin(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.RouteLogin);
  }
}