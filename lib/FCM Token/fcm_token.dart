import 'package:firebase_messaging/firebase_messaging.dart';

class FcmToken {
  dynamic token;
  FcmToken({this.token});

  static gettingToken() async {
    var tokens = await FirebaseMessaging.instance.getToken();
    return tokens;
  }
}
