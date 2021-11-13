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

class Searchingg extends StatefulWidget {
  Searchingg({this.details, this.searchlist});
  final details;
  final searchlist;

  @override
  _SearchinggscreenState createState() => _SearchinggscreenState();
}

class _SearchinggscreenState extends State<Searchingg> {
  var search = TextEditingController();
  var decodeDetails, token, searchListAllData,decodeDetailsData,decodeDetailsnew,selectedSubs;
  final l = Logger();
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];
  List<int> apireceivedid = [];
  bool isList = false;
  @override
  void initState() {
    l.wtf('inside init state');
    functioncall();
    gosearchapi(
        gettingFromWhere: 'fromInItState',
        gettingWhatParameter: widget.searchlist);
    Provider.of<WishList>(context, listen: false).getWishlistnew();
    super.initState();
  }

  functioncall() async {
    l.wtf(widget.searchlist);
  }

  gosearchapi({gettingFromWhere, gettingWhatParameter}) async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');

      token = userDetails[5];
      print("$token" + "27linechapter");
      var selectedParameterToSend;
      if (gettingFromWhere == 'fromInItState') {
        selectedParameterToSend = gettingWhatParameter;
      } else {
        selectedParameterToSend = gettingWhatParameter;
      }
      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/$selectedParameterToSend');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token.toString(),
      });
      setState(() {
        searchListAllData = json.decode(response.body);
        decodeDetails=searchListAllData['data'];
      });
      l.e(searchListAllData);
    });
  }
  // getWishlist() async {
  //   Shared().shared().then((value) async {
  //     var userDetails = await value.getStringList('storeData');
  //     token = userDetails[5];
  //     print("$token" + "27linechapter");
  //     var url =
  //         Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
  //     var response = await http.get(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': token
  //     });
  //     decodeDetailsData = json.decode(response.body);
  //     print(decodeDetailsData);
  //     l.i(decodeDetailsData);
  //     for (var i in decodeDetailsData['result'])
  //       youtubevideoId!.add(i['video_id']);
  //     l.e(youtubevideoId);

  //     print(decodeDetails);
  //     print("47chapteritem");
  //   });
  // }

  // searchApi() async {
  //   Shared().shared().then((value) async {
  //     var userDetails = await value.getStringList('storeData');
  //     // setState(() {
  //     token = userDetails[5];
  //     print("$token" + "27linechapter");
  //     // });
  //
  //     print(userDetails);
  //
  //     print("28chapter");
  //     print(33);
  //
  //     var url = Uri.parse(
  //         'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/${widget}');
  //     //  var url = Uri.parse(
  //     //         'https://www.cviacserver.tk/parampara/v1/getTourSinglePlan/${userId[1]}');
  //     var response = await http.get(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': token
  //     });
  //     // decodeDetailsData = json.decode(response.body);
  //     // setState(() {
  //     //   decodeDetails = decodeDetailsData['data'];
  //     // });
  //   });
  // }
  searchApi(String Selectedsubjectname) async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      selectedSubs = Selectedsubjectname.replaceAll(" ", "");
      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/$selectedSubs');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      decodeDetailsData = json.decode(response.body);
      decodeDetailsnew = decodeDetailsData['data'];
      setState(() {
        decodeDetails = decodeDetailsnew;
      });
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
                          gosearchapi(
                              gettingFromWhere: 'textFormField',
                              gettingWhatParameter: search.text);
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
                  child: searchListAllData == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: (height),
                          width: width * 0.97,
                          child: ListView.builder(
                              itemCount: searchListAllData['data'].length,
                              itemBuilder: (context, index) {
                                // isList = apireceivedid
                                //     .contains(searchListAllData['data'][index]['video_id']);
                                // var s = Provider.of<WishList>(
                                //     context,
                                //     listen:
                                //     true).youtubeVideoIdnew
                                //     .contains(decodeDetails[index]['video_id']);

                                // print('lllllllllllllllllllllll,  $s');
                                // var you = YoutubePlayerController(
                                //   initialVideoId: YoutubePlayer.convertUrlToId(
                                //       searchListAllData['data'][index]
                                //           ['link'])!,
                                //   flags: const YoutubePlayerFlags(
                                //     controlsVisibleAtStart: true,
                                //     hideControls: true,
                                //     autoPlay: false,
                                //     isLive: false,
                                //   ),
                                // );

                                return InkWell(
                                  // onTap: () {
                                  //   print(131);
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => Play(
                                  //                 link: searchListAllData['data'][index]
                                  //                     ['link'],
                                  //               )));
                                  // },
                                  child: Container(
                                      height: (height) * 0.12,
                                      width: width * 0.8,
                                      // child: YoutubePlayer(
                                      //   controller: you,
                                      // ),
                                      child: Card(
                                        elevation: 10,
                                        color: HexColor('#FFFFFF'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: width * 0.2,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(searchListAllData['data'][index]['link'])}/0.jpg',
                                                    fit: BoxFit.cover,
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
                                                        // Text(searchListAllData['data']['data'][index]
                                                        //     ['link']),
                                                        Text(
                                                          searchListAllData[
                                                                          'data']
                                                                      [index]
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
                                                          searchListAllData[
                                                                          'data']
                                                                      [index]
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
                                                    Provider.of<WishList>(
                                                        context,
                                                        listen: false)
                                                        .checkingLikeAndUnlikeVideos(
                                                        context: context,
                                                        gettingVideoId: decodeDetails[index]['video_id']);
                                                    // checking(
                                                    //     link: decodeDetails[
                                                    //     index]['video_id']);
                                                    // Provider.of<WishList>(
                                                    //     context,
                                                    //     listen:
                                                    //     false).getwishvideoidlist();
                                                  },
                                                  child: Icon(Icons.favorite,
                                                      color: Provider.of<WishList>(
                                                          context,
                                                          listen:
                                                          true).youtubeVideoIdnew
                                                          .contains(decodeDetails[index]['video_id'])
                                                          ? Colors.pink
                                                          : Colors.grey)),
                                              // LikeButton(
                                              //   // onTap: () {

                                              //   circleColor: CircleColor(
                                              //       start: Color(0xFFF44336),
                                              //       end: Color(0xFFF44336)),
                                              //   likeBuilder: (isLiked) {

                                              //     return Icon(
                                              //       Icons.favorite,
                                              //       size: 30,
                                              //       color: isLiked
                                              //           ? Colors.pink
                                              //           : Colors.teal,
                                              //     );
                                              //   },

                                              // countBuilder: (){
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
}
