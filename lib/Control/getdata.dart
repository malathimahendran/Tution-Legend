import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:flutter/material.dart';

class GetSubjectList extends ChangeNotifier {
  final l = Logger();
  List subjectList = [];
  List subjectListData = [];
  List decodeDetails = [];
  getSubjectListApi(String standardclass) async {
    String url =
        "https://www.cviacserver.tk/tuitionlegend/register/get_subjects/$standardclass";
    print(url);
    var subjectResponse = await http.get(Uri.parse(url));
    var decodeDetails = json.decode(subjectResponse.body);
    print('$decodeDetails , line 18qqqqqqqqqqqqqqqqqqqq');
    subjectListData.clear();
    // subjectListData = ['Recent', '    All    '];
    for (int i = 0; i < decodeDetails['data'].length; i++) {
      print('$i,line 20');
      subjectListData.add(decodeDetails['data'][i]['subject']);
    }

    subjectList = subjectListData;
    print('$subjectList , line 25');

    notifyListeners();
  }

  searchApi(String Selectedsubjectname) async {
    String token;
    // var selectedSubs;
    var decodeDetailsData;
    var decodeDetailsnew;
    Shared().shared().then((value) async {
      var userDetails = value.getStringList('storeData');
      token = userDetails[5];
      // selectedSubs = Selectedsubjectname.replaceAll(" ", "");
      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/$Selectedsubjectname');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);
      decodeDetailsnew = decodeDetailsData['data'];
      if (decodeDetailsnew.length > 3) {
        decodeDetailsnew.removeRange(3, (decodeDetailsnew.length));
      }
      decodeDetailsnew.add(decodeDetailsnew[0]);

      decodeDetails = decodeDetailsnew;
      l.v('its here');
      l.v(decodeDetails);
      notifyListeners();
    });
  }
}
