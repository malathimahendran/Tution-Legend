import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../play.dart';

class Videowishlist extends StatefulWidget {
  const Videowishlist({Key? key}) : super(key: key);

  @override
  _VideowishlistState createState() => _VideowishlistState();
}

class _VideowishlistState extends State<Videowishlist> {
  @override
  void initState() {
    super.initState();
    getWishlist();
  }

  var search = TextEditingController();
  var decodeDetails, decodeDetailsData;
  String? token;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];
  final l = Logger();
  var wishlistDetails;
  getWishlist() async {
    Shared().shared().then((value) async {
      List userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "27linechapter");
      l.wtf(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw');
      l.w(token);
      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      });
      decodeDetailsData = json.decode(response.body);
      print(decodeDetailsData);
      l.i(decodeDetailsData);

      for (var i in decodeDetailsData['result']) {
        youtubevideoId!.add(i['video_id']);
        l.e(youtubevideoId);
      }

      setState(() {
        wishlistDetails = decodeDetailsData['result'];
      });

      print(decodeDetails);
      print("47chapteritem");
    });
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
          body: Container(
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
                      // searchApi();
                    },
                    controller: search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search videos',
                      suffixIcon: InkWell(
                        onTap: () {
                          // searchApi();
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                      ),
                      // icon: Icon(Icons.search),
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 11, color: HexColor('#7B7777'))),
                      // prefixIcon: icon,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: HexColor('#27DEBF'))),
                    ),
                  ),
                ),
                SizedBox(
                  height: ((height - status)) * 0.04,
                ),
                Flexible(
                  child: wishlistDetails == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: height,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90)),
                          child: ListView.builder(
                              itemCount: wishlistDetails.length,
                              itemBuilder: (context, index) {
                                var s = youtubevideoId!.contains(
                                    wishlistDetails[index]['video_id']);
                                // print('lllllllllllllllllllllll,  $s');
                                var you = YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(
                                      wishlistDetails[index]['link'])!,
                                  flags: const YoutubePlayerFlags(
                                    controlsVisibleAtStart: true,
                                    hideControls: true,
                                    autoPlay: false,
                                    isLive: false,
                                  ),
                                );

                                return InkWell(
                                  child: Container(
                                      height: (height) * 0.12,
                                      width: width,
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Play(
                                                                link: wishlistDetails[
                                                                        index]
                                                                    ['link'],
                                                              )));
                                                },
                                                child: Container(
                                                  width: width * 0.2,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: YoutubePlayer(
                                                      controller: you,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Image.asset('assets/Carousel/image1.png'),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Container(
                                                    width: width * 0.58,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Text(wishlistDetails['data'][index]
                                                        //     ['link']),
                                                        Text(
                                                          wishlistDetails[index]
                                                                  ['subject']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: HexColor(
                                                                  '#0A1C22')),
                                                        ),
                                                        Text(
                                                          wishlistDetails[index]
                                                                  ['lesson']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: HexColor(
                                                                  '#0A1C22')),
                                                        ),
                                                      ],
                                                    )),
                                              ),

                                              InkWell(
                                                  onTap: () {
                                                    checking(
                                                        link: wishlistDetails[
                                                            index]['video_id']);
                                                  },
                                                  child: Icon(Icons.favorite,
                                                      color: s
                                                          ? Colors.pink
                                                          : Colors.grey)),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              }),
                        ),
                ),
                SizedBox(
                  height: ((height - status)) * 0.02,
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
