import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() {
  runApp(MyAppp());
}

class MyAppp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutterant.com Tutorials',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // disableCapture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Disable Screenshots")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Users are not allowed to take screenshots or record screen. ",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ));
  }

  // disableCapture() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }
}
// package com.example.tutionmaster
// import android.view.WindowManager.LayoutParams;
// import io.flutter.embedding.android.FlutterActivity;
// import io.flutter.embedding.engine.FlutterEngine;


// class MainActivity: FlutterActivity() {
//   override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//     window.addFlags(LayoutParams.FLAG_SECURE)
//     super.configureFlutterEngine(flutterEngine)
//   }
// }