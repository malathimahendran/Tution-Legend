import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Play extends StatefulWidget {
  Play({this.link});
  final link;

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  YoutubePlayerController? _controller;
  final l = Logger();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  void dispose() {
    _controller?.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    // ]);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link)!,
      flags: const YoutubePlayerFlags(
        // controlsVisibleAtStart: true,
        hideControls: false,
        autoPlay: false,
        isLive: false,
      ),
    );

    // var heights = MediaQuery.of(context).orientation;
    // l.i(heights);

    l.e(widget.link);
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        // _controller.toggleFullScreenMode();
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          child: Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: YoutubePlayer(controller: _controller!),
            ),
          ),
        ),
      ),
    );
  }
}
