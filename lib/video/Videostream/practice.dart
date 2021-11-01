// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class Practice extends StatefulWidget {
//   @override
//   _PracticeState createState() => _PracticeState();
// }

// class _PracticeState extends State<Practice> {
//   var you;
//   YoutubePlayerController? _youtubePlayerController;
//   @override
//   void initState() {
//     super.initState();
//     _youtubePlayerController = YoutubePlayerController(
//       initialVideoId: '_uOgXpEHNbc',
//       flags: const YoutubePlayerFlags(
//         controlsVisibleAtStart: true,
//         // hideControls: true,
//         autoPlay: false,
//         isLive: false,
//       ),
//     );
//     //
//     // _youtubePlayerController!.cue('_uOgXpEHNbc');

//     if (mounted) {
//       print("line 28$mounted");
//       setState(() {
//         if (_youtubePlayerController!.initialVideoId == '_uOgXpEHNbc') {
//           _youtubePlayerController!.pause(

//           );
//           print('inside if');
//         } else {
//           _youtubePlayerController!.play();
//           print('inside else');
//         }
//       });
//     }
//   }

//   // void didPop() {
//   //   print("didPop");
//   //   super.didChangeDependencies();
//   // }

//   /// Called when the top route has been popped off, and the current route
//   /// shows up.
//   // void didPopNext() {
//   //   print("didPopNext");
//   //   YoutubePlayerController.of(context)!.reload();
//   // }

//   /// Called when the current route has been pushed.
//   // void didPush() {
//   //   print("didPush");
//   // }

//   /// Called when a new route has been pushed, and the current route is no
//   /// longer visible.

//   // void didPushNext() {
//   //   print("didPushNext");
//   //   YoutubePlayerController.of(context)!.pause();
//   // }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: YoutubePlayer(
//           controller: _youtubePlayerController!,
//           progressIndicatorColor: Colors.red,
//           showVideoProgressIndicator: true,
//         ),
//       ),
//     );
//   }
// }
