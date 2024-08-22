import 'package:contact/constants/strings.dart';
import 'package:contact/views/screen/Screen.dart';
import 'package:contact/views/screen/home_screen.dart';
import 'package:contact/views/screen/login_screen.dart';
import 'package:contact/views/screen/register_screen.dart';
import 'package:contact/views/screen/splash_screen.dart';
import 'package:flutter/material.dart';


class RouteController {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Constants.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Constants.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Constants.homeRoute:
        return MaterialPageRoute(builder: (context) =>  HomeScreen());
      case Constants.ScreenRoute:
        return MaterialPageRoute(builder: (context) => Screen(),);
    }
    return null;
  }
}
