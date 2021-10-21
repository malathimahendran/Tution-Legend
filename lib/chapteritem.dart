import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/play.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'SHARED PREFERENCES/shared_preferences.dart';

class Chapteritem extends StatefulWidget {
  const Chapteritem({Key? key}) : super(key: key);

  @override
  _ChapteritemState createState() => _ChapteritemState();
}

class _ChapteritemState extends State<Chapteritem> {
  var search = TextEditingController();
  var decodeDetails, token;
  searchApi() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        token = userDetails[4];
        print("$token" + "27linechapter");
      });

      print(userDetails);
      print("28chapter");
    });
    var url = Uri.parse(
        'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/${search.text}');
    //  var url = Uri.parse(
    //         'https://www.cviacserver.tk/parampara/v1/getTourSinglePlan/${userId[1]}');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    });
    decodeDetails = json.decode(response.body);
    setState(() {});
    print(decodeDetails['data']);
  }

  @override
  Widget build(BuildContext context) {
    print(search);
    print(36);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    return SafeArea(
      child: Scaffold(
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
                controller: search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search videos',
                  suffixIcon: InkWell(
                    onTap: () {
                      searchApi();
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                  ),
                  // icon: Icon(Icons.search),
                  hintStyle: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 11, color: HexColor('#7B7777'))),
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
              child: decodeDetails == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: decodeDetails['data'].length,
                      itemBuilder: (context, index) {
                        var you = YoutubePlayerController(
                          initialVideoId: YoutubePlayer.convertUrlToId(
                              decodeDetails['data'][index]['link'])!,
                          flags: const YoutubePlayerFlags(
                            controlsVisibleAtStart: true,
                            hideControls: true,
                            autoPlay: false,
                            isLive: false,
                          ),
                        );
                        print(decodeDetails['data'][index]['link'].runtimeType);
                        print(109);
                        return Container(
                            height: (height) * 0.18,
                            width: width * 0.2,
                            // child: YoutubePlayer(
                            //   controller: you,
                            // ),
                            child: Card(
                              color: HexColor('#FFFFFF'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print(131);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Play(
                                                      link:
                                                          decodeDetails['data']
                                                              [index]['link'],
                                                    )));
                                      },
                                      child: Container(
                                        width: width * 0.25,
                                        child: YoutubePlayer(
                                          controller: you,
                                        ),
                                      ),
                                    ),
                                    // Image.asset('assets/Carousel/image1.png'),
                                    Container(
                                        width: width * 0.58,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Text(decodeDetails['data'][index]
                                            //     ['link']),
                                            Text(
                                              decodeDetails['data'][index]
                                                  ['title'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: HexColor('#0A1C22')),
                                            ),
                                          ],
                                        )),
                                    Icon(
                                      Icons.favorite_outline_outlined,
                                      color: HexColor('#FF465C'),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }),
            ),
            SizedBox(
              height: ((height - status)) * 0.02,
            ),
          ],
        ),
      )),
    );
  }
}
