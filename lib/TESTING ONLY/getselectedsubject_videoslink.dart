import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:flutter/material.dart';

class GetSubjectList extends ChangeNotifier {
  List subjectList = [];
  List subjectListData = [];

  getSubjectListApi(String standardclass) async {
    String url =
        "https://www.cviacserver.tk/tuitionlegend/register/get_subjects/$standardclass";
    print(url);
    var subjectResponse = await http.get(Uri.parse(url));
    var decodeDetails = json.decode(subjectResponse.body);
    print('$decodeDetails , line 18');
    subjectList.clear();
    subjectListData.clear();
    for (int i = 0; i < decodeDetails['data'].length; i++) {
      print('$i,line 20');
      subjectListData.add(decodeDetails['data'][i]['subject']);
    }
    subjectList = subjectListData;
    print('$subjectList , line 25 anna');

    notifyListeners();

    print(subjectListData);
    print('hiiii');
    // setState(() {
    //   subjectList = subjectListdata;
    // });
  }
}