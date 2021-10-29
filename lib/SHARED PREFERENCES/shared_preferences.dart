import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  Future shared() async {
    var share = await SharedPreferences.getInstance();
    return share;
  }
}

storingAllDetails(
    {userName,
    storeemail,
    phone,
    standard,
    profileImage,
    token,
    googleId,
    enrollmentNumber,
    school,
    academicYear}) async {
  List<String> storing = [
    userName ?? "",
    storeemail,
    phone ?? "",
    standard,
    profileImage ?? "",
    token ?? "",
    googleId ?? "",
    enrollmentNumber ?? "",
    school ?? "",
    academicYear ?? ""
  ];

  print(storing);
  print(320);
  Shared().shared().then((value) => value.setStringList('storeData', storing));
}
