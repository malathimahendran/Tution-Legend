import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  Future shared() async {
    var share = await SharedPreferences.getInstance();
    return share;
  }
}
