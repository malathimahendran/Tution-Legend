import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/play.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'likeandunlikeapi.dart';

class Allvideo extends StatefulWidget {
  @override
  _SearchinggscreenState createState() => _SearchinggscreenState();
}

class _SearchinggscreenState extends State<Allvideo> {
  var search = TextEditingController();
  var decodeDetailsData, token, searchListAllData;
  var decodeDetails;
  final l = Logger();
  bool isLoading = false;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];
  List<int> apireceivedid = [];
  bool isList = false;
  @override
  void initState() {
    l.wtf('inside init state');
    allvideoApi();
    Provider.of<WishList>(context, listen: false).getWishlistnew();
    super.initState();
  }

  allvideoApi() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        token = userDetails[5];
        print("$token" + "27linechapter");
      });

      print(userDetails);

      print("28chapter");
      print(33);

      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/All');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);
      setState(() {
        decodeDetails = decodeDetailsData['data'];
      });

      print("47chapteritem");
    });
  }

  searchApi() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      token = userDetails[5];
      print("$token" + "27linechapter");
      // });

      print(userDetails);

      print("28chapter");
      print(33);

      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/${search.text}');
      //  var url = Uri.parse(
      //         'https://www.cviacserver.tk/parampara/v1/getTourSinglePlan/${userId[1]}');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);
      l.w(decodeDetailsData);
      setState(() {
        decodeDetails = decodeDetailsData['data'];
      });

      print(decodeDetails['data']);
      print("47chapteritem");
    });
    // print('44');
    // decodeDetails = json.decode(response.body);
    // setState(() {});
    // print(decodeDetails['data']);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: decodeDetails == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/ProfilePage/mainbackground.png'),
                  )),
                  margin: EdgeInsets.only(
                    top: status,
                  ),
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.06,
                        width: width * 0.9,
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            searchApi();
                          },
                          controller: search,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search videos',
                            suffixIcon: InkWell(
                              onTap: () {
                                searchApi();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: HexColor('#243665'),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // icon: Icon(Icons.search),
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 11, color: HexColor('#7B7777'))),
                            // prefixIcon: icon,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: HexColor('#27DEBF'))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ((height - status)) * 0.02,
                      ),
                      Flexible(
                        child: decodeDetails == null ||
                                decodeDetails.length == 0
                            ? Container(
                                child: isLoading == false
                                    ? TweenAnimationBuilder(
                                        duration: Duration(seconds: 3),
                                        tween: Tween(begin: 0.0, end: 100.0),
                                        builder: (context, _, child) {
                                          return Center(
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator(
                                                  color: Colors.teal),
                                            ),
                                          );
                                        },
                                        onEnd: () {
                                          setState(() {
                                            isLoading = true;
                                            print(isLoading);
                                          });
                                        },
                                      )
                                    : Center(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.search,
                                                size: height * 0.1,
                                              ),
                                              Text(
                                                'No Results Found',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              )
                            : Container(
                                height: (height),
                                width: width * 0.97,
                                child: ListView.builder(
                                    itemCount: decodeDetails.length,
                                    itemBuilder: (context, index) {
                                      // var checkingTrueOrFalse = youtubevideoId!
                                      //     .contains(searchListAllData['data'][index]
                                      //         ['video_id']);
                                      // l.i(Provider.of<WishList>(context,
                                      //         listen: false)
                                      //     .youtubeVideoLink);
                                      // var s =
                                      //     Provider.of<WishList>(context, listen: true)
                                      //         .youtubeVideoLink[index]
                                      //         (searchListAllData['data']
                                      //             [index]['video_id']);
                                      // print('lllllllllllllllllllllll,  $s');
                                      return InkWell(
                                        onTap: () {
                                          print(131);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Play(
                                                        link:
                                                            decodeDetails[index]
                                                                ['link'],
                                                      )));
                                        },
                                        child: Container(
                                            height: (height) * 0.18,
                                            width: width * 0.8,
                                            // child: YoutubePlayer(
                                            //   controller: you,
                                            // ),
                                            child: Card(
                                              elevation: 5,
                                              color: HexColor('#FFFFFF'),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Container(
                                                        height: height * 0.12,
                                                        width: width * 0.23,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Image.network(
                                                            'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(decodeDetails[index]['link'])}/0.jpg',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Image.asset('assets/Carousel/image1.png'),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 13),
                                                      child: Container(
                                                          width: width * 0.54,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Text(searchListAllData['data']['data'][index]
                                                              //     ['link']),
                                                              Text(
                                                                decodeDetails[
                                                                            index]
                                                                        [
                                                                        'subject']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: HexColor(
                                                                        '#0A1C22')),
                                                              ),
                                                              Text(
                                                                decodeDetails[
                                                                            index]
                                                                        [
                                                                        'lesson']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: HexColor(
                                                                        '#0A1C22')),
                                                              ),
                                                            ],
                                                          )),
                                                    ),

                                                    InkWell(
                                                        onTap: () {
                                                          Provider.of<WishList>(
                                                                  context,
                                                                  listen: false)
                                                              .checkingLikeAndUnlikeVideos(
                                                                  context:
                                                                      context,
                                                                  gettingVideoId:
                                                                      decodeDetails[
                                                                              index]
                                                                          [
                                                                          'video_id']);
                                                        },
                                                        child: Icon(
                                                            Icons.favorite,
                                                            color: Provider.of<
                                                                            WishList>(
                                                                        context,
                                                                        listen:
                                                                            true)
                                                                    .youtubeVideoIdnew
                                                                    .contains(decodeDetails[
                                                                            index]
                                                                        [
                                                                        'video_id'])
                                                                ? Colors.pink
                                                                : Colors.grey)),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      );
                                    }),
                              ),
                      ),
                    ],
                  ),
                )),
    );
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
}
