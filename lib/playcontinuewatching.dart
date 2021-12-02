import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/videos/videomainscreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tutionmaster/Control/continuewating.dart';
import 'package:tutionmaster/model/Watched_video.dart';

class Playcontinue extends StatefulWidget {
  Playcontinue({required this.videoid1, required this.durationwatched});
  final videoid1;
  int durationwatched;
  @override
  _PlaycontinueState createState() => _PlaycontinueState();
}

class _PlaycontinueState extends State<Playcontinue> {
  YoutubePlayerController? _controller;
  final l = Logger();
  // double? value;
  // int? duration;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    Future.delayed(Duration(seconds: 1));
    party();
    super.initState();
  }

  party() async {
    // int newDura = await gettingDura();
    // l.w(newDura);
    // duration = newDura;
    // l.i(duration);
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoid1,
      flags: YoutubePlayerFlags(
        hideControls: false,
        autoPlay: widget.durationwatched != 0 ? true : false,
        isLive: false,
        startAt: widget.durationwatched,
      ),
    );
    // setState(() {});
  }

  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l.e(widget.videoid1);
    return WillPopScope(
      onWillPop: () async {
        l.w(_controller!.value.position);
        Duration currentDuration = _controller!.value.position;
        l.i(currentDuration);
        Provider.of<SqliteLocalDatabase>(context, listen: false)
            .insertvideolist(Watchedvideos(
                videoid: widget.videoid1, duration: currentDuration.inSeconds));
        // SharedPreferences sharedPreferences =
        // await SharedPreferences.getInstance();
        // sharedPreferences.setDouble(
        //     'dura', (currentDuration.inSeconds.toDouble()));
        // Future.delayed(Duration(seconds: 2));
        // Provider.of<SqliteLocalDatabase>(context, listen: false).changing();
        // Provider.of<SqliteLocalDatabase>(context, listen: false).getvideolist();
        l.w('line 77 above return in playcontinuewatching');
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        Navigator.pop(context, 'hello');
        return Future.value(
          true,
        );
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

// gettingDura() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   value = sharedPreferences.getDouble('dura');
//   l.e(value);
//   return value!.round();
// }

}
