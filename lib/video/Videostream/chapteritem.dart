// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:logger/logger.dart';
// import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
// import 'package:tutionmaster/play.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class Chapteritem extends StatefulWidget {
//   const Chapteritem({Key? key}) : super(key: key);

//   @override
//   _ChapteritemState createState() => _ChapteritemState();
// }

// class _ChapteritemState extends State<Chapteritem> {
//   var search = TextEditingController();
//   var decodeDetails, token, decodeDetailsData;
//   final l = Logger();
//   List<int>? youtubevideoId = [];
//   bool isIconClicked = false;
//   List<int> iconClick = [];
//   List<int> apireceivedid = [];
//   bool isList = false;
//   @override
//   void initState() {
//     super.initState();
//     allvideoApi();
//     getWishlist();
//   }

//   getWishlist() async {
//     var url =
//         Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
//     var response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization':
//           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
//     });
//     decodeDetailsData = json.decode(response.body);
//     print(decodeDetailsData);
//     l.i(decodeDetailsData);
//     for (var i in decodeDetailsData['result'])
//       youtubevideoId!.add(i['video_id']);
//     l.e(youtubevideoId);

//     print(decodeDetails);
//     print("47chapteritem");
//   }

//   allvideoApi() async {
//     Shared().shared().then((value) async {
//       // var userDetails = await value.getStringList('storeData');
//       // setState(() {
//       //   token = userDetails[5];
//       //   print("$token" + "27linechapter");
//       // });

//       // print(userDetails);

//       // print("28chapter");
//       // print(33);

//       var url = Uri.parse(
//           'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/All');
//       var response = await http.get(url, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization':
//             'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
//       });
//       decodeDetailsData = json.decode(response.body);
//       setState(() {
//         decodeDetails = decodeDetailsData['data'];
//       });

//       print("47chapteritem");
//     });
//   }

//   searchApi() async {
//     Shared().shared().then((value) async {
//       // var userDetails = await value.getStringList('storeData');
//       // // setState(() {
//       // token = userDetails[5];
//       // print("$token" + "27linechapter");
//       // // });

//       // print(userDetails);

//       // print("28chapter");
//       // print(33);

//       var url = Uri.parse(
//           'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/${search.text}');
//       //  var url = Uri.parse(
//       //         'https://www.cviacserver.tk/parampara/v1/getTourSinglePlan/${userId[1]}');
//       var response = await http.get(url, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization':
//             'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAwOTFmMWMzLTBkMGUtNGVmMy1iMDYyLWU3Y2JlMzBlN2Q3YyIsImlhdCI6MTYzNDg5NzMwNiwiZXhwIjoxNjM3NDg5MzA2fQ.K9aqwhG-4ZpHbZF_qrsJ0-unlC51jI6494asGwzyAuY',
//       });
//       decodeDetailsData = json.decode(response.body);
//       setState(() {
//         decodeDetails = decodeDetailsData['data'];
//       });

//       print(decodeDetails['data']);
//       print("47chapteritem");
//     });
//     // print('44');
//     // decodeDetails = json.decode(response.body);
//     // setState(() {});
//     // print(decodeDetails['data']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print("$decodeDetails,widgetchapter");
//     print(search);
//     print(36);
//     print(38);
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var status = MediaQuery.of(context).padding.top;
//     var bottom = kBottomNavigationBarHeight;
//     return SafeArea(
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             // color: Colors.blue,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//               image: AssetImage('assets/ProfilePage/mainbackground.png'),
//             )),
//             margin: EdgeInsets.only(
//               top: status,
//             ),
//             height: height,
//             width: width,
//             child: Column(
//               children: [
//                 Container(
//                   height: height * 0.06,
//                   width: width * 0.9,
//                   child: TextFormField(
//                     textInputAction: TextInputAction.search,
//                     onFieldSubmitted: (value) {
//                       // searchApi();
//                     },
//                     controller: search,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'Search videos',
//                       suffixIcon: InkWell(
//                         onTap: () {
//                           // searchApi();
//                         },
//                         child: Icon(
//                           Icons.search,
//                           color: Colors.red,
//                         ),
//                       ),
//                       // icon: Icon(Icons.search),
//                       hintStyle: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                               fontSize: 11, color: HexColor('#7B7777'))),
//                       // prefixIcon: icon,
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(color: Colors.grey.shade300)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(color: HexColor('#27DEBF'))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: ((height - status)) * 0.04,
//                 ),
//                 Flexible(
//                   child: decodeDetails == null
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : ListView.builder(
//                           itemCount: decodeDetails.length,
//                           itemBuilder: (context, index) {
//                             // isList = apireceivedid
//                             //     .contains(decodeDetails[index]['video_id']);
//                             var s = youtubevideoId!
//                                 .contains(decodeDetails[index]['video_id']);
//                             print('lllllllllllllllllllllll,  $s');
//                             var you = YoutubePlayerController(
//                               initialVideoId: YoutubePlayer.convertUrlToId(
//                                   decodeDetails[index]['link'])!,
//                               flags: const YoutubePlayerFlags(
//                                 controlsVisibleAtStart: true,
//                                 hideControls: true,
//                                 autoPlay: false,
//                                 isLive: false,
//                               ),
//                             );
//                             // print(decodeDetails[index]['link']);
//                             // print(youtubevideoId!.length);
//                             // print(109);
//                             return InkWell(
//                               // onTap: () {
//                               //   print(131);
//                               //   Navigator.push(
//                               //       context,
//                               //       MaterialPageRoute(
//                               //           builder: (context) => Play(
//                               //                 link: decodeDetails[index]
//                               //                     ['link'],
//                               //               )));
//                               // },
//                               child: Container(
//                                   height: (height) * 0.15,
//                                   width: width * 0.2,
//                                   // child: YoutubePlayer(
//                                   //   controller: you,
//                                   // ),
//                                   child: Card(
//                                     elevation: 10,
//                                     color: HexColor('#FFFFFF'),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15.0),
//                                     ),
//                                     child: Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Container(
//                                             width: width * 0.25,
//                                             child: YoutubePlayer(
//                                               controller: you,
//                                             ),
//                                           ),
//                                           // Image.asset('assets/Carousel/image1.png'),
//                                           Padding(
//                                             padding: EdgeInsets.only(left: 10),
//                                             child: Container(
//                                                 width: width * 0.58,
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     // Text(decodeDetails['data'][index]
//                                                     //     ['link']),
//                                                     Text(
//                                                       decodeDetails[index]
//                                                               ['subject']
//                                                           .toString(),
//                                                       style: TextStyle(
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: HexColor(
//                                                               '#0A1C22')),
//                                                     ),
//                                                     Text(
//                                                       decodeDetails[index]
//                                                               ['lesson']
//                                                           .toString(),
//                                                       style: TextStyle(
//                                                           fontSize: 15,
//                                                           color: HexColor(
//                                                               '#0A1C22')),
//                                                     ),
//                                                   ],
//                                                 )),
//                                           ),

//                                           InkWell(
//                                               onTap: () {
//                                                 checking(
//                                                     link: decodeDetails[index]
//                                                         ['video_id']);
//                                               },
//                                               child: Icon(Icons.favorite,
//                                                   color: s
//                                                       ? Colors.pink
//                                                       : Colors.teal)),
//                                           // LikeButton(
//                                           //   // onTap: () {

//                                           //   circleColor: CircleColor(
//                                           //       start: Color(0xFFF44336),
//                                           //       end: Color(0xFFF44336)),
//                                           //   likeBuilder: (isLiked) {

//                                           //     return Icon(
//                                           //       Icons.favorite,
//                                           //       size: 30,
//                                           //       color: isLiked
//                                           //           ? Colors.pink
//                                           //           : Colors.teal,
//                                           //     );
//                                           //   },

//                                           // countBuilder: (){
//                                         ],
//                                       ),
//                                     ),
//                                   )),
//                             );
//                           }),
//                 ),
//                 SizedBox(
//                   height: ((height - status)) * 0.02,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }

//   checking({link}) async {
//     print('${link.runtimeType}');
//     if (link != null) {
//       final bool sV = youtubevideoId!.contains(link);
//       if (sV) {
//         setState(() {
//           print('wwwwwwwwwwwwwwwwwwwww,  inside if');

//           youtubevideoId!.remove(link);
//         });
//         await unlikevideo(link);
//       } else {
//         print('hhhhhhhhhhhhhhhhhhhhhhhhhh,  inside else');

//         setState(() {
//           youtubevideoId!.add(link);
//           print("Zzzzzzzzzzzzzzzzzzzzzzzz${youtubevideoId!.length}");
//         });
//         await likevideo(link);
//       }
//     } else
//       return;
//   }

//   likevideo(videoID) async {
//     var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/like');
//     var response = await http.post(url, body: {
//       'video_id': videoID.toString()
//     }, headers: {
//       'Authorization':
//           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
//     });
//     print(response.body);
//   }

//   unlikevideo(videoId) async {
//     var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/dislike');
//     var response = await http.post(url, body: {
//       'video_id': videoId.toString()
//     }, headers: {
//       'Authorization':
//           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
//     });
//     print(response.body);
//   }
// }
