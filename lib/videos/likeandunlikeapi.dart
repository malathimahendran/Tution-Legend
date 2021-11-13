import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

likevideo(videoId) async {
  Shared().shared().then((value) async {
    var userDetails = await value.getStringList('storeData');
    var token = userDetails[5];
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/like');
    var response = await http.post(url,
        body: {'video_id': videoId.toString()},
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

class WishList extends ChangeNotifier {
  final l = Logger();
  String? token;
  List youtubeVideoId = [];
  List youtubeVideoLink = [];
  bool sayingTrueOrFalse = false;
  getWishlist() async {
    Shared().shared().then((value) async {
      List userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      });
      youtubeVideoId.clear();

      var wishListJsonData = json.decode(response.body);

      youtubeVideoLink = wishListJsonData['result'];
      // for (var i in youtubeVideoLink) youtubeVideoId.add(i['video_id']);
      // l.w(youtubeVideoId);
      l.w(youtubeVideoLink);
      notifyListeners();
    });
  }

  checkingLikeAndUnlikeVideos({Map? gettingVideoId, context}) async {
    l.w(gettingVideoId);
    // List onlyVideoId = [];

    // for (var i in youtubeVideoLink) onlyVideoId.add(i['video_id']);

    // var k = onlyVideoId.contains(gettingVideoId);
    var k = youtubeVideoLink.contains(gettingVideoId);
    if (k) {
      l.w('inside if');

      await unlikevideo(gettingVideoId!['video_id']);
      Provider.of<WishList>(context, listen: false)
          .youtubeVideoLink
          .removeWhere((element) => element == gettingVideoId);
      l.v(youtubeVideoLink);

      notifyListeners();
    } else {
      l.w('inside else');
      // l.i(gettingVideoId);
      await likevideo(gettingVideoId!['video_id']);
      Provider.of<WishList>(context, listen: false)
          .youtubeVideoLink
          .add(gettingVideoId);
      l.v(youtubeVideoLink);

      notifyListeners();
    }
  }
}
