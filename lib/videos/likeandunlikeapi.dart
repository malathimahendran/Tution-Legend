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
  List youtubeVideoIdnew = [];
  List youtubeVideoLink = [];
  bool sayingTrueOrFalse = false;
  getWishlist() async {
    Shared().shared().then((value) async {
      List userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      l.w(token);
      var url =
      Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      });
      youtubeVideoId.clear();
      youtubeVideoLink.clear();
      var wishListJsonData = json.decode(response.body);
      l.e("check here$wishListJsonData");
      for (var i in wishListJsonData['result']) {
        youtubeVideoId.add(i['video_id']);
        l.e(youtubeVideoId);
      }
      youtubeVideoLink = wishListJsonData['result'];
      notifyListeners();
    });
  }
  getWishlistnew() async {
    Shared().shared().then((value) async {
      List userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      l.w(token);
      var url =
      Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      });
      youtubeVideoId.clear();
      youtubeVideoLink.clear();
      var wishListJsonData = json.decode(response.body);
      l.e("check here$wishListJsonData");
      for (var i in wishListJsonData['result']) {
        youtubeVideoId.add(i['video_id']);
        l.e(youtubeVideoId);
      }
      youtubeVideoLink = wishListJsonData['result'];
      youtubeVideoIdnew=youtubeVideoId;
      notifyListeners();
    });
  }

  checkingLikeAndUnlikeVideos({int? gettingVideoId, context}) async {
    // List onlyVideoId = [];

    // for (var i in youtubeVideoLink) onlyVideoId.add(i['video_id']);

    var k =  Provider.of<WishList>(context, listen: false)
        .youtubeVideoIdnew.contains(gettingVideoId);
    if (k) {
      l.i(gettingVideoId);
      l.w('inside if');

      await unlikevideo(gettingVideoId);
      Provider.of<WishList>(context, listen: false)
          .youtubeVideoLink
          .removeWhere((element) => element['video_id'] == gettingVideoId);
      Provider.of<WishList>(context, listen: false)
          .youtubeVideoIdnew
          .remove(gettingVideoId);
      l.v(youtubeVideoLink);

      sayingTrueOrFalse = false;
      notifyListeners();
    } else {
      l.i(gettingVideoId);

      l.w('inside else');

      await likevideo(gettingVideoId);
      Provider.of<WishList>(context, listen: false)
          .youtubeVideoIdnew
          .add(gettingVideoId);

      sayingTrueOrFalse = true;
      notifyListeners();
    }
  }

}
