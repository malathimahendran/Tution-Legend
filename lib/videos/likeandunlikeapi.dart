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
      l.d(token);
      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      });
      // youtubeVideoId.clear();
      var wishListJsonData = json.decode(response.body);
      youtubeVideoLink = wishListJsonData['result'];
      // for (var i in wishListJsonData['result'])
      //   youtubeVideoId.add(i['video_id']);
      // l.w(youtubeVideoId);
      l.w(youtubeVideoLink);
      notifyListeners();
    });
  }

  findingTrueOrFalse({context, get}) {
    print('inside the function  ');
    print(youtubeVideoLink);
    if (youtubeVideoLink.isNotEmpty) {
      for (Map i
          in Provider.of<WishList>(context, listen: false).youtubeVideoLink) {
        print(i);
        if (i['video_id'] == get!['video_id']) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  checkingLikeAndUnlikeVideos({Map? gettingVideoId, context}) async {
    l.i(gettingVideoId);
    l.i(youtubeVideoLink);
    // l.i(youtubeVideoId);
    // List onlyVideoId = [];

    // for (var i in youtubeVideoLink) onlyVideoId.add(i['video_id']);

    // var k = onlyVideoId.contains(gettingVideoId);
    var k = await findingTrueOrFalse(context: context, get: gettingVideoId);

    // var k = Provider.of<WishList>(context, listen: false)
    //     .youtubeVideoLink
    //     .where((element) {
    //   if (element['video_id'] == gettingVideoId!['video_id']) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // });

    l.wtf(k);
    // var s = youtubeVideoId.contains(gettingVideoId!['video_id']);
    // l.wtf(s);

    if ((k == true)) {
      l.v('inside if');
      l.v(Provider.of<WishList>(context, listen: false).youtubeVideoLink);
      await unlikevideo(gettingVideoId!['video_id']);
      Provider.of<WishList>(context, listen: true)
          .youtubeVideoLink
          .removeWhere((element) => element == gettingVideoId['video_id ']);
      l.v(Provider.of<WishList>(context, listen: false).youtubeVideoLink);

      // Provider.of<WishList>(context, listen: false)
      //     .youtubeVideoLink
      //     .remove(gettingVideoId);
      // Provider.of<WishList>(context, listen: false)
      //     .youtubeVideoId
      //     .add(gettingVideoId['video_id']);

      l.v(youtubeVideoLink);
      // l.wtf(youtubeVideoId);
      notifyListeners();
    } else if (k == false) {
      l.v('inside else');
      // l.i(gettingVideoId);
      await likevideo(gettingVideoId!['video_id']);
      // Provider.of<WishList>(context, listen: false)
      //     .youtubeVideoLink
      //     .add(gettingVideoId);
      Provider.of<WishList>(context, listen: false)
          .youtubeVideoLink
          .add(gettingVideoId);
      // Provider.of<WishList>(context, listen: false)
      //     .youtubeVideoId
      //     .remove(gettingVideoId['video_id']);
      l.v(youtubeVideoLink);
      // l.wtf(youtubeVideoId);

      notifyListeners();
    }
  }
}
