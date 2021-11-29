import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'ALL API FOLDER/all_api.dart';
import 'Control/continuewating.dart';
import 'SHARED PREFERENCES/shared_preferences.dart';
import 'model/Watched_video.dart';
import 'package:http/http.dart' as http;

class Play extends StatefulWidget {
  Play({this.link});
  final link;

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  YoutubePlayerController? _controller;
  final l = Logger();
  bool? status;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    disableCapture();
    super.initState();
    getPlanDetails();
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
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_HARDWARE_ACCELERATED);
  }

  getPlanDetails() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      var token = userDetails[5];
      print("$token" + "51 line");

      var url = Uri.parse(getPlanDetailsCall);

      var response = await http.get(url, headers: {'Authorization': token});
      var decodeDetailsData = json.decode(response.body);
      l.e(decodeDetailsData);

      var result = decodeDetailsData['result'];
      l.wtf("$result,homescreenvideodisplayfreepremiumplan");

      status = decodeDetailsData['status'];
      l.v(status);
    });
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
        )),
      )),
    );
  }
}
