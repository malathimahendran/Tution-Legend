import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Play extends StatefulWidget {
  Play({this.link});
  final link;

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  final l = Logger();

  @override
  Widget build(BuildContext context) {
    var heights = MediaQuery.of(context).orientation;
    l.i(heights);

    l.e(widget.link);
    return Scaffold(
      body: Container(
        height: heights == Orientation.landscape ? double.infinity : 200,
        child: Center(
          child: Container(
            height: 200,
            width: double.infinity,
            child: YoutubePlayer(
                controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(widget.link)!,
              flags: const YoutubePlayerFlags(
                // controlsVisibleAtStart: true,
                hideControls: false,
                autoPlay: false,
                isLive: false,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
