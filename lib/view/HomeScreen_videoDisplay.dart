import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/play.dart';
import 'package:tutionmaster/videos/likeandunlikeapi.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class HomeScreenVideos extends StatefulWidget {
  String Selectedsubjectname;
  HomeScreenVideos({required this.Selectedsubjectname});
  @override
  _HomeScreenVideosState createState() => _HomeScreenVideosState();
}

class _HomeScreenVideosState extends State<HomeScreenVideos> {
  var decodeDetails, decodeDetailsData;
  String? token;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];
  final l = Logger();
  var wishlistDetails;
  // getWishlist() async {
  //   Shared().shared().then((value) async {
  //     List userDetails = await value.getStringList('storeData');
  //     token = userDetails[5];
  //     print("$token" + "27linechapter");
  //     l.wtf(
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw');
  //     l.w(token);
  //     var url =
  //         Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
  //     var response = await http.get(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': token!
  //     });
  //     decodeDetailsData = json.decode(response.body);
  //     print(decodeDetailsData);
  //     l.i(decodeDetailsData);

  //     for (var i in decodeDetailsData['result']) {
  //       youtubevideoId!.add(i['video_id']);
  //       l.e(youtubevideoId);
  //     }

  //     setState(() {
  //       wishlistDetails = decodeDetailsData['result'];
  //     });

  //     print(decodeDetails);
  //     print("47chapteritem");
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetSelectedsubjectsVideos>(context, listen: false)
        .searchApi(widget.Selectedsubjectname);
    // getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.Selectedsubjectname);
    print('hi');

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    return SafeArea(child: Scaffold(
      body: Consumer<GetSelectedsubjectsVideos>(
          builder: (context, GetSelectedsubjectsVideos, _) {
        return Column(
          children: [
            SizedBox(
              height: ((height - status)) * 0.04,
            ),
            Flexible(
              child: GetSelectedsubjectsVideos.decodeDetails == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: height,
                        width: width * 0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ListView.builder(
                            itemExtent: height * 0.2,
                            itemCount:
                                GetSelectedsubjectsVideos.decodeDetails.length,
                            itemBuilder: (context, index) {
                              var s = youtubevideoId!.contains(
                                  GetSelectedsubjectsVideos.decodeDetails[index]
                                      ['video_id']);
                              // print('lllllllllllllllllllllll,  $s');
                              var you = YoutubePlayerController(
                                initialVideoId: YoutubePlayer.convertUrlToId(
                                    GetSelectedsubjectsVideos
                                        .decodeDetails[index]['link'])!,
                                flags: const YoutubePlayerFlags(
                                  controlsVisibleAtStart: true,
                                  hideControls: true,
                                  autoPlay: false,
                                  isLive: false,
                                ),
                              );

                              return InkWell(
                                child: Container(
                                    height: (height) * 0.18,
                                    width: width * 0.8,
                                    // child: YoutubePlayer(
                                    //   controller: you,
                                    // ),
                                    child: Card(
                                      color: HexColor('#FFFFFF'),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Container(
                                        width: width,
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // SizedBox(
                                            //   width: width * 0.01,
                                            // ),
                                            InkWell(
                                              // onTap: () {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               Play(
                                              //                 link: GetSelectedsubjectsVideos
                                              //                         .decodeDetails[
                                              //                     index]['link'],
                                              //               )));
                                              // },
                                              child: Container(
                                                height: height * 0.14,
                                                width: width * 0.3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.network(
                                                      'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(GetSelectedsubjectsVideos.decodeDetails[index]['link'])}/0.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.1,
                                            ),
                                            // Image.asset('assets/Carousel/image1.png'),
                                            Container(
                                                width: width * 0.48,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Text(wishlistDetails['data'][index]
                                                    //     ['link']),
                                                    Text(
                                                      GetSelectedsubjectsVideos
                                                          .decodeDetails[index]
                                                              ['subject']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: HexColor(
                                                              '#0A1C22')),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.005,
                                                    ),
                                                    Text(
                                                      GetSelectedsubjectsVideos
                                                          .decodeDetails[index]
                                                              ['lesson']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: HexColor(
                                                              '#0A1C22')),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.002,
                                                    ),

                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .access_alarm),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Provider.of<WishList>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .checkingLikeAndUnlikeVideos(
                                                                      context:
                                                                          context,
                                                                      gettingVideoId:
                                                                          GetSelectedsubjectsVideos
                                                                              .decodeDetails[index]);

                                                              // GetSelectedsubjectsVideos
                                                              //     .decodeDetails[index]
                                                              //         ['subject']
                                                            },
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: Provider.of<
                                                                              WishList>(
                                                                          context,
                                                                          listen:
                                                                              true)
                                                                      .youtubeVideoLink
                                                                      .contains(
                                                                          GetSelectedsubjectsVideos
                                                                              .decodeDetails[index])
                                                                  ? Colors.pink
                                                                  : Colors.grey,
                                                              size: 45,
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   '1hr 9mnt',
                                                          //   style: TextStyle(
                                                          //       fontSize: 11,
                                                          //       color: HexColor(
                                                          //           '#0A1C22')),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      ' Free',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: HexColor(
                                                              '#0A1C22')),
                                                    ),
                                                  ],
                                                )),

                                            // InkWell(
                                            //     onTap: () {
                                            //       checking(
                                            //           link: GetSelectedsubjectsVideos
                                            //                   .decodeDetails[
                                            //               index]['video_id']);
                                            //     },
                                            //     child: Icon(Icons.favorite,
                                            //         color: s
                                            //             ? Colors.pink
                                            //             : Colors.grey)),
                                            // SizedBox(
                                            //   width: width * 0.01,
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      ),
                    ),
            ),
            SizedBox(
              height: ((height - status)) * 0.02,
            ),
          ],
        );
      }),
    ));
  }

  checking({link}) async {
    print('${link.runtimeType}');
    if (link != null) {
      final bool sV = youtubevideoId!.contains(link);
      if (sV) {
        setState(() {
          print('wwwwwwwwwwwwwwwwwwwww,  inside if');

          youtubevideoId!.remove(link);
        });
        await unlikevideo(link);
      } else {
        print('hhhhhhhhhhhhhhhhhhhhhhhhhh,  inside else');

        setState(() {
          youtubevideoId!.add(link);
          print("Zzzzzzzzzzzzzzzzzzzzzzzz${youtubevideoId!.length}");
        });
        await likevideo(link);
      }
    } else
      return;
  }

  likevideo(videoID) async {
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/like');
    var response = await http.post(url,
        body: {'video_id': videoID.toString()},
        headers: {'Authorization': token!});
    print(response.body);
  }

  unlikevideo(videoId) async {
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/dislike');
    var response = await http.post(url,
        body: {'video_id': videoId.toString()},
        headers: {'Authorization': token!});
    print(response.body);
  }
}
