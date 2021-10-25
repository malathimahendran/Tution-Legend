import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/SplashScreen/splashscreen.dart';
import 'package:tutionmaster/TESTING%20ONLY/test_one.dart';

import 'HomePage/try.dart';
import 'Login/loginpage.dart';
import 'ProfilePage/profilepage.dart';
import 'Register/register.dart';
import 'Slider/carosalSlider.dart';
import 'StartingLearningPage/startlearning.dart';

// void main() {
//   runApp(MyApp());
// }
main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TestOne(),
      // initialRoute: 'splashscreen',
      // routes: {
      //   'splashscreen': (context) => SplashScreen(),
      //   'carosalSlider': (context) => Carosel(),
      //   'loginpage': (context) => LoginPage(),
      //   'startlearning': (context) => StartLearning(),
      //   'registerpage': (context) => Register(),
      //   'homescreen': (context) => HomeScreen(),
      //   'profile': (context) => Profile()
      // },
    );
  }
}
