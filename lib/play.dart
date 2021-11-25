import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'Control/continuewating.dart';
import 'model/Watched_video.dart';

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
    disableCapture();
    super.initState();
  }

  void dispose() {
    _controller?.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    super.dispose();
  }

  disableCapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
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
        l.w(_controller!.value.metaData.duration);
        l.w(_controller!.metadata.duration);
        l.w(_controller!.value.buffered);

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        l.w(_controller!.value.position);
        Duration currentDuration = _controller!.value.position;
        l.i(currentDuration);
        Provider.of<SqliteLocalDatabase>(context, listen: false)
            .insertvideolist(Watchedvideos(
                videoid: YoutubePlayer.convertUrlToId(widget.link)!,
                duration: currentDuration.inSeconds));
        Provider.of<SqliteLocalDatabase>(context, listen: false).getvideolist();
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
