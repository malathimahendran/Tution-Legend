import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Videoduration extends ChangeNotifier {
  final l = Logger();
  var yt = YoutubeExplode();
  var duration1;
  var video;
  getvideoduration(String link) async {
    video = await yt.videos.get(link);
    duration1 = video.duration;
    l.e(duration1);
    notifyListeners();
  }
}
