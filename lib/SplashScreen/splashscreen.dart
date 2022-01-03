import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/Control/continuewating.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Notifications/notification_class.dart';
import 'package:tutionmaster/Slider/carosalSlider.dart';
import 'package:tutionmaster/SplashScreen/constants.dart';
import '../SHARED PREFERENCES/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final l = Logger();
  var selectHere;
  var checkloggedfirsttime;
  @override
  void initState() {
    firebaseNotification();

    SharedPreferences.getInstance().then(
      (prefs) {
        checkloggedfirsttime = prefs.getBool("checkingGetstarted");
      },
    );
    super.initState();

    selectingHere().whenComplete(() {
      Multi.check();
      Future.delayed(Duration(seconds: 2), () {
        l.i('insideselectinghere');
        l.i(Multi.isComingIn);
        if (checkloggedfirsttime == null) {
          Navigator.popAndPushNamed(context, AllRouteNames.carosalSlider);
        } else if (selectHere == null) {
          Navigator.popAndPushNamed(context, AllRouteNames.loginpage);
        } else
          Navigator.popAndPushNamed(context, AllRouteNames.homescreen);
      });
    });
  }

  gettingToken() async {
    var tokens = await FirebaseMessaging.instance.getToken();
    return tokens;
  }

  firebaseNotification() async {
    await MessageNotification.initialize();
    var m = FirebaseMessaging.instance.isAutoInitEnabled;
    l.wtf(m);
    var k = FirebaseMessaging.instance.requestPermission();
    l.wtf(k);
    //when app is not openend and we receive notification and then we will touch it
    //then the app is openend
    // FcmToken(token: gettingToken());

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      l.wtf('inside firebase messaging getInitialMessage');
      if (value != null) {
        l.i(value);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      l.wtf('inside firebase messaging onMessageListen');
      if (message.notification != null) {
        l.i(message.notification!.title);
        l.i(message.notification!.body);
        MessageNotification.messageDisplay(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      l.wtf('inside firebase messaging onMessageOpenedApp');
      if (message.data != null) {
        l.i(message.data);
        l.i(message.notification);
      }
    });
    ;
  }

  Future selectingHere() async {
    await Shared().shared().then((val) {
      selectHere = val.getStringList('storeData');
      print(selectHere);
      // l.wtf('in splashscreen selectingHereFunction');
    });

    // var shared = await SharedPreferences.getInstance();
    // setState(() {
    //   selectHere = shared.getStringList('pic');
    // });
    // print(selectHere);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;

    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(
        top: status,
      ),
      height: height,
      width: width,
      child: Column(
        children: [
          Container(
            height: (height - status) * 0.25,
          ),
          Container(
            height: (height - status) * 0.75,
            child: Column(
              children: [
                Container(
                    child: Image.asset(
                  'assets/SplashScreen/splashScreen.png',
                  width: width * 0.5,
                  height: height * 0.5,
                )),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [Text('TUITION'), Text('LEGEND')],
          // )
        ],
      ),
    ));
  }
}
