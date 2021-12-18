import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/Control/videoduration.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/ProfilePage/HELPER%20FUNCTION/provider_for_edit_page.dart';
import 'package:tutionmaster/SplashScreen/splashscreen.dart';
import 'package:tutionmaster/videos/likeandunlikeapi.dart';
import 'package:tutionmaster/videos/paymentgetforvideosfreeorpremium.dart';
import 'package:tutionmaster/work.dart';
import 'ALLROUTES/routegenerator.dart';
import 'Control/continuewating.dart';
import 'Control/getdata.dart';
import 'Control/getvideoduration.dart';
import 'HomePage/changepassword.dart';
import 'HomePage/try.dart';
import 'Login/loginpage.dart';
import 'Login/validationtry.dart';
import 'ProfilePage/profilepage.dart';
import 'Register/register.dart';
import 'Slider/carosalSlider.dart';
import 'StartingLearningPage/startlearning.dart';
import 'videos/vlc.dart';
import 'package:telephony/telephony.dart';
import 'package:logger/logger.dart';

// Future onBackgroundMessageHandling(RemoteMessage message) async {
//   final l = Logger();
//   if (message != null) {
//     l.i(message.notification!.title);
//     l.i(message.data.toString());
//     print(message.notification!.body);
//     print(message.data.toString());
//   }
// }
onBackgroundMessage(SmsMessage message) {
  final l = Logger();
  l.w("onBackgroundMessage called");
  l.wtf('inside void main');
}

main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future disableCapture() async {
    //disable screenshots and record screen in current screen
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

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
        ChangeNotifierProvider(create: (context) {
          return ProviderFunction();
        }),
        ChangeNotifierProvider(create: (context) {
          return WishList();
        }),
        ChangeNotifierProvider.value(
          value: SqliteLocalDatabase(),
        ),
        ChangeNotifierProvider.value(
          value: Videoduration(),
        ),
        ChangeNotifierProvider.value(
          value: GetVideoduration(),
        ),
        ChangeNotifierProvider(create: (context) {
          return GetPaymentDetails();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "poppins",
        ),
        // home: Register(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:telephony/telephony.dart';

// onBackgroundMessage(SmsMessage message) {
//   debugPrint("onBackgroundMessage called");
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _message = "";
//   final telephony = Telephony.instance;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   onMessage(SmsMessage message) async {
//     setState(() {
//       _message = message.body ?? "Error reading message body.";
//     });
//   }

//   onSendStatus(SendStatus status) {
//     setState(() {
//       _message = status == SendStatus.SENT ? "sent" : "delivered";
//     });
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.

//     final bool? result = await telephony.requestPhoneAndSmsPermissions;

//     if (result != null && result) {
//       telephony.listenIncomingSms(
//           onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
//     }

//     if (!mounted) return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(child: Text("Latest received SMS: $_message")),
//           TextButton(
//               onPressed: () async {
//                 await telephony.openDialer("123413453");
//               },
//               child: Text('Open Dialer'))
//         ],
//       ),
//     ));
//   }
// }
