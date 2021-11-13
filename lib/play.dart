import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  var duration;
  var value;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    party();
    super.initState();
  }

  party() async {
    int newDura = await gettingDura();
    l.w(newDura);
    duration = newDura;
    l.i(duration);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link)!,
      flags: YoutubePlayerFlags(
        hideControls: false,
        autoPlay: duration != 0 ? true : false,
        isLive: false,
        startAt: duration!,
      ),
    );
    setState(() {});
  }

  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l.e(widget.link);
    return WillPopScope(
      onWillPop: () async {
        l.w(_controller!.metadata.duration);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        l.w(_controller!.value.position);
        Duration currentDuration = _controller!.value.position;
        l.i(currentDuration);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setDouble(
            'dura', (currentDuration.inSeconds.toDouble()));
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          child: Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: _controller != null
                  ? YoutubePlayer(controller: _controller!)
                  : Text('Waiting'),
            ),
          ),
        ),
      ),
    );
  }

  gettingDura() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    value = sharedPreferences.getDouble('dura');
    l.e(value);
    return value!.round();
  }
}
