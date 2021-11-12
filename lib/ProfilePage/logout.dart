import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:logger/logger.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

class LogOutForAll {
  static final l = Logger();
  static outTemporary(context) async {
    // await FacebookAuth.instance.logOut().then((value) {
    //   l.i('log out for face book');
    // });
    await GoogleSignIn().signOut().then((value) {
      l.i('log out gor google');
    });
    Shared().shared().then((value) {
      value.clear();
      l.i('clear in shared preference');

      var hello = value.getStringList('storeData');
      print(hello);
      print('logout temporart');
    });
    print('home screen logout line 126');

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  final String thumbnailLink =
      "https://img.youtube.com/vi/<insert-youtube-video-id-here>/0.jpg";
}
