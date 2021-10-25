import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/SplashScreen/splashscreen.dart';


import 'package:tutionmaster/TESTING%20ONLY/test_one.dart';


import 'ALLROUTES/routegenerator.dart';
import 'Control/getdata.dart';
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
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: GetSubjectList())],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Chapteritem(),
        // initialRoute: '/',
        // onGenerateRoute: RouteGenerator.generateRoute,
        // routes: {
        //   'splashscreen': (context) => SplashScreen(),
        //   'carosalSlider': (context) => Carosel(),
        //   'loginpage': (context) => LoginPage(),
        //   'startlearning': (context) => StartLearning(),
        //   'registerpage': (context) => Register(),
        //   'homescreen': (context) => HomeScreen(),
        //   'profile': (context) => Profile()
        // },
      ),
    );
  }
}
