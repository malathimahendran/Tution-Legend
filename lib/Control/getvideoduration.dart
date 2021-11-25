import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class GetVideoduration extends ChangeNotifier {
  var yt = YoutubeExplode();
  var dura;
  Future<void> getduration(String link) async {
    var k = await yt.videos.get(link);
    dura = k.duration.toString();
    notifyListeners();
  }
}
