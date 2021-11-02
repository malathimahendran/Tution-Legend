// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class Searchvideo extends StatefulWidget {
//   Searchvideo({Key? key}) : super(key: key);

//   @override
//   _SearchvideoState createState() => _SearchvideoState();
// }

// class _SearchvideoState extends State<Searchvideo> {
//   var search = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     var status = MediaQuery.of(context).padding.top;
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//             image: AssetImage('assets/ProfilePage/mainbackground.png'),
//           )),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: Container(
//                       height: height * 0.06,
//                       width: width * 0.9,
//                       child: TextFormField(
//                         textInputAction: TextInputAction.search,
//                         onFieldSubmitted: (value) {
//                           // searchApi();
//                         },
//                         controller: search,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Search videos',
//                           suffixIcon: InkWell(
//                             onTap: () {
//                               // searchApi();
//                             },
//                             child: Icon(
//                               Icons.search,
//                               color: Colors.red,
//                             ),
//                           ),
//                           // icon: Icon(Icons.search),
//                           hintStyle: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                   fontSize: 11, color: HexColor('#7B7777'))),
//                           // prefixIcon: icon,
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               borderSide:
//                                   BorderSide(color: Colors.grey.shade300)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               borderSide:
//                                   BorderSide(color: HexColor('#27DEBF'))),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: ((height - status)) * 0.03,
//                   ),
//                   Text(
//                     'Continue Watching',
//                     style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: HexColor('#0A1C22')),
//                   ),
//                   SizedBox(
//                     height: ((height - status)) * 0.01,
//                   ),
//                   Container(
//                     width: width * 0.9,
//                     height: height * 0.15,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: 5,
//                         itemBuilder: (context, index) {
//                           // var you = YoutubePlayerController(
//                           //   initialVideoId: YoutubePlayer.convertUrlToId(
//                           //       decodeDetails[index]['link'])!,
//                           //   flags: const YoutubePlayerFlags(
//                           //     controlsVisibleAtStart: true,
//                           //     hideControls: true,
//                           //     autoPlay: false,
//                           //     isLive: false,
//                           //   ),
//                           // );
//                           // print(decodeDetails[index]['link'].runtimeType);
//                           // print(109);
//                           return InkWell(
//                             onTap: () {
//                               print(131);
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => Play(
//                               //               link: decodeDetails[index]
//                               //                   ['link'],
//                               //             )));
//                             },
//                             child: Container(
//                               width: width * 0.4,
//                               child: Card(
//                                 color: HexColor('#FFFFFF'),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                   SizedBox(
//                     height: ((height - status)) * 0.01,
//                   ),
//                   Text(
//                     'Maths',
//                     style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: HexColor('#0A1C22')),
//                   ),
//                   SizedBox(
//                     height: ((height - status)) * 0.01,
//                   ),
//                   Container(
//                     width: width * 0.9,
//                     height: height * 0.3,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 6,
//                       gridDelegate:
//                           new SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: 1.5,
//                       ),
//                       itemBuilder: (context, index) {
//                         return Container(
//                           width: width * 0.9,
//                           height: (height * 0.5) * 0.1,
//                           child: Card(
//                             color: HexColor('#FFFFFF'),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: ((height - status)) * 0.01,
//                   ),
//                   Text(
//                     'Science',
//                     style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: HexColor('#0A1C22')),
//                   ),
//                   SizedBox(
//                     height: ((height - status)) * 0.01,
//                   ),
//                   Container(
//                     width: width * 0.9,
//                     height: height * 0.3,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 4,
//                       gridDelegate:
//                           new SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: 1.5,
//                       ),
//                       itemBuilder: (context, index) {
//                         return Container(
//                           child: Card(
//                             color: HexColor('#FFFFFF'),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
