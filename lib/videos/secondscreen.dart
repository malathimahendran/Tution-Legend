import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/Payment%20Screens/paymentDesign.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/play.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'likeandunlikeapi.dart';
import 'paymentgetforvideosfreeorpremium.dart';

class Secondscreen extends StatefulWidget {
  String Selectedsubjectname;
  Secondscreen({required this.Selectedsubjectname});

  @override
  _SecondscreenState createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {
  var search = TextEditingController();
  var decodeDetails, token, decodeDetailsData;
  var decodeDetails12;
  final l = Logger();
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];
  List<int> apireceivedid = [];
  bool isList = false;
  @override
  // void initState() {
  //   super.initState();
  //   searchApi();
  //   getWishlist();
  // }
  void initState() {
    super.initState();
    functioncall();
    Provider.of<WishList>(context, listen: false).getWishlistnew();
  }

  functioncall() async {
    await searchApi();
    await getWishlist();
  }

  gosearchApi() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      token = userDetails[5];
      print("$token" + "27linechapter");
      // });

      print(userDetails);

      print("28chapter");
      print(33);

      var url = Uri.parse('$searchApiCall${search.text}');
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

  getWishlist() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "27linechapter");
      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      decodeDetailsData = json.decode(response.body);
      print(decodeDetailsData);
      l.i(decodeDetailsData);
      for (var i in decodeDetailsData['result'])
        youtubevideoId!.add(i['video_id']);
      l.e(youtubevideoId);

      print(decodeDetails);
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
          'http://www.cviacserver.tk/tuitionlegend/home/class_wise_lectures/title/${widget.Selectedsubjectname}');
      //  var url = Uri.parse(
      //         'https://www.cviacserver.tk/parampara/v1/getTourSinglePlan/${userId[1]}');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      decodeDetailsData = json.decode(response.body);
      setState(() {
        decodeDetails = decodeDetailsData['data'];
      });
      decodeDetails12 = decodeDetailsData['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("$decodeDetails,widgetchapter");
    print(search);
    print(36);
    print(38);
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
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(widget.Selectedsubjectname,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#0A1C22'))),
                  ),
                ),
                SizedBox(
                  height: ((height - status)) * 0.04,
                ),
                Flexible(
                  child: decodeDetailsData == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: (height),
                          width: width * 0.97,
                          child: ListView.builder(
                              itemCount: decodeDetails.length,
                              itemBuilder: (context, index) {
                                // isList = apireceivedid
                                //     .contains(decodeDetails[index]['video_id']);
                                var s = youtubevideoId!.contains(
                                    decodeDetails12[index]['video_id']);
                                print('lllllllllllllllllllllll,  $s');

                                // print(decodeDetails[index]['link']);
                                // print(youtubevideoId!.length);
                                // print(109);
                                return InkWell(
                                  onTap: () {
                                    print(131);
                                    decodeDetails[index]['subscribe'] == 0 ||
                                            Provider.of<GetPaymentDetails>(
                                                        context,
                                                        listen: false)
                                                    .statusCheckingPremiumOrFree ==
                                                true
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Play(
                                                      link: decodeDetails[index]
                                                          ['link'],
                                                    )))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentDesign()));
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
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Container(
                                                  height: height * 0.12,
                                                  width: width * 0.23,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.network(
                                                      'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(decodeDetails[index]['link'])}/0.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Image.asset('assets/Carousel/image1.png'),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Container(
                                                    width: width * 0.52,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Text(decodeDetails['data'][index]
                                                        //     ['link']),
                                                        Text(
                                                          decodeDetails[index]
                                                                  ['lesson']
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
                                                          decodeDetails[index][
                                                                  'description']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: HexColor(
                                                                  '#0A1C22')),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_alarm,
                                                                color: HexColor(
                                                                    '#009688'),
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: width *
                                                                    0.01,
                                                              ),

                                                              customText(
                                                                  getText: decodeDetails[
                                                                          index]
                                                                      ['link'])
                                                              // Text(Provider.of<
                                                              //             GetVideoduration>(
                                                              //         context,
                                                              //         listen:
                                                              //             true)
                                                              //     .dura
                                                              //     .toString()
                                                              //     .substring(
                                                              //         2, 7))
                                                            ],
                                                          ),
                                                        ),
                                                        decodeDetails[index][
                                                                    'subscribe'] ==
                                                                0
                                                            ? Text(
                                                                'Free',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: HexColor(
                                                                        '#27AE60')),
                                                              )
                                                            : Text(
                                                                'Premium',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: HexColor(
                                                                        '#F39C12')),
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
                                                            gettingVideoId:
                                                                decodeDetails[
                                                                        index][
                                                                    'video_id']);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(Icons.favorite,
                                                        color: Provider.of<
                                                                        WishList>(
                                                                    context,
                                                                    listen:
                                                                        true)
                                                                .youtubeVideoIdnew
                                                                .contains(decodeDetails[
                                                                        index][
                                                                    'video_id'])
                                                            ? Colors.pink
                                                            : Colors.grey),
                                                  )),
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
}
