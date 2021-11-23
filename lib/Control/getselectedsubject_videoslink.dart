import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class GetSelectedsubjectsVideos extends ChangeNotifier {
  final l = Logger();
  var decodeDetails, token, decodeDetailsData, selectedSubs;
  searchApi(String Selectedsubjectname) async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "27linechapter");
      print(userDetails);
      print(15);
      print("28chapter");
      print(33);
      if (decodeDetails != null) decodeDetails.clear();

      selectedSubs = Selectedsubjectname.replaceAll(" ", "");
      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/$selectedSubs');
      //  var url = Uri.parse(
      //         'https://www.cviacserver.tk/parampara/v1/getTourSinglePlan/${userId[1]}');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);
      decodeDetails = decodeDetailsData['data'];
      notifyListeners();
      ge(boss: decodeDetails);
      // print(decodeDetails['data']);
      // print("47chapteritem");
    });
  }

  ge({List? boss}) async {
    l.w(boss);
    var k;
    for (var i in boss!) {
      await Future.delayed(Duration(seconds: 1));
      k = await YoutubeExplode().videos.get(i['link']);
      l.wtf(k.duration);
    }
    // l.wtf(k.duration);
  }

  // gettingAllDurations({context}) {
  //   Future.delayed(Duration(seconds: 5), () {
  //     l.w(Provider.of<GetSelectedsubjectsVideos>(context).decodeDetails);
  //   });
  // }
}
