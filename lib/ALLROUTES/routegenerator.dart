import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Login/argumentpass.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:tutionmaster/Register/register.dart';
import 'package:tutionmaster/Slider/carosalSlider.dart';
import 'package:tutionmaster/SplashScreen/splashscreen.dart';
import 'package:tutionmaster/StartingLearningPage/startlearning.dart';

class RouteGenerator {
  static var logger = Logger();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    logger.w('=====>   ${settings.name}');
    switch (settings.name) {
      case AllRouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AllRouteNames.carosalSlider:
        return MaterialPageRoute(builder: (context) => Carosel());
      case AllRouteNames.loginpage:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case AllRouteNames.registerpage:
        ArgumentPass ag = settings.arguments as ArgumentPass;
        var deviceId = ag.deviceId;
        var googleUser = ag.googleUser;
        return MaterialPageRoute(
            builder: (context) => Register(
                  deviceId: deviceId,
                  googleuser: googleUser,
                ));
      case AllRouteNames.startlearning:
        return MaterialPageRoute(builder: (context) => StartLearning());
      case AllRouteNames.homescreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
