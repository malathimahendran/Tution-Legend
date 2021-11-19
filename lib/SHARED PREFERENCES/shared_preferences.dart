import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  Future shared() async {
    var share = await SharedPreferences.getInstance();
    return share;
  }
}

storingAllDetails({
  userName,
  storeemail,
  phone,
  standard,
  profileImage,
  token,
  googleId,
  enrollmentNumber,
  school,
  academicYear,
  standardFromGetApi,
}) async {
  final l = Logger();

  List<String> storing = [
    userName ?? "",
    storeemail ?? "",
    phone ?? "",
    standard ?? "",
    profileImage ?? "",
    token ?? "",
    googleId ?? "",
    enrollmentNumber ?? "",
    school ?? "",
    academicYear ?? "",
    standardFromGetApi ?? "",
  ];

  // print("${storing[token].toString()},zzzzzzzzzzzzzzline 34");

  l.wtf(storing);
  print('line 42 in sharedpreference320');
  Shared().shared().then((value) => value.setStringList('storeData', storing));
  l.w(storing);
}
