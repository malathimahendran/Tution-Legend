import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/ProfilePage/HELPER%20FUNCTION/provider_for_edit_page.dart';
import 'package:tutionmaster/SplashScreen/splashscreen.dart';

import 'ALLROUTES/routegenerator.dart';
import 'Control/getdata.dart';
import 'HomePage/try.dart';
import 'Login/loginpage.dart';
import 'ProfilePage/profilepage.dart';
import 'Register/register.dart';
import 'Slider/carosalSlider.dart';
import 'StartingLearningPage/startlearning.dart';
import 'Videostream/chapteritem.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetSubjectList(),
        ),
        ChangeNotifierProvider.value(
          value: GetSelectedsubjectsVideos(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: Profile(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
