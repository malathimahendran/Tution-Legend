import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

likevideo(videoID) async {
  Shared().shared().then((value) async {
    var userDetails = await value.getStringList('storeData');
    var token = userDetails[5];
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/like');
    var response = await http.post(url,
        body: {'video_id': videoID.toString()},
        headers: {'Authorization': token!});
    print(response.body);
  });
}

unlikevideo(videoId) async {
  Shared().shared().then((value) async {
    var userDetails = await value.getStringList('storeData');
    var token = userDetails[5];
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/dislike');
    var response = await http.post(url,
        body: {'video_id': videoId.toString()},
        headers: {'Authorization': token!});
    print(response.body);
  });
}
