import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/Control/getvideoduration.dart';
import 'package:tutionmaster/Control/videoduration.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:tutionmaster/Register/register.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/play.dart';
import 'package:tutionmaster/videos/likeandunlikeapi.dart';
import 'package:tutionmaster/videos/paymentgetforvideosfreeorpremium.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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

  var you;
  var video1, url;
  YoutubeExplode yt = YoutubeExplode();
  var video;
  var duration;

  @override
  void initState() {
    super.initState();

    Provider.of<GetSelectedsubjectsVideos>(context, listen: false)
        .searchApi(widget.Selectedsubjectname);
    Provider.of<WishList>(context, listen: false).getWishlistnew();
    Provider.of<GetPaymentDetails>(context, listen: false).getPlanDetails();
    // getPlanDetails();
    // Provider.of<GetSelectedsubjectsVideos>(context, listen: false)
    //     .gettingAllDurations(context: context);
    // gett();

    // getWishlist();
  }

  main(sam) {
    if (sam == sam) {
      return Text('waiting');
    }

    // var duration;
    // var duration = dura.duration;
    // // // l.w(duration);
    // if (duration != null) {
    //   return Text('$duration');
    // } else {
    //   return Text('waiting');
    // }
  }

  gett() async {
    l.i('inside line 47');
    l.i(yt.videos.commentsClient);
    l.i(yt.videos.closedCaptions);

    l.i(yt);
    // l.w(yt.httpClient.get('Dpp1sIL1m5Q'));
    var lika = 'https://youtube.com/watch?v=Dpp1sIL1m5Q';
    // var y = await yt.httpClient.get('https://youtube.com/watch?v=Dpp1sIL1m5Q');
    // l.w(y.body);
    var lm = await yt.videos.get('https://www.youtube.com/watch?v=eKkJm0jeUds');
    l.w(lm.duration);
// 'https://www.youtube.com/watch?v=eKkJm0jeUds'
    // var video = await yt.videos.get('Dpp1sIL1m5Q');
    // duration = video.duration;
    // l.wtf(duration);

    // Future.delayed(Duration(seconds: 3), () {
    //   yt.close();
    // });
  }

  // getPlanDetails() async {
  //   Shared().shared().then((value) async {
  //     var userDetails = await value.getStringList('storeData');
  //     // setState(() {
  //     var token = userDetails[5];
  //     print("$token" + "51 line");

  //     var url = Uri.parse(getPlanDetailsCall);

  //     var response = await http.get(url, headers: {'Authorization': token});
  //     decodeDetailsData = json.decode(response.body);
  //     l.e(decodeDetailsData);
  //     var decode = response.body;
  //     l.e(decode);
  //     var result = decodeDetailsData['result'];
  //     l.wtf("$result,homescreenvideodisplayfreepremiumplan");

  //     statuscheckingpremiumorfree = decodeDetailsData['status'];
  //     l.v(statuscheckingpremiumorfree);
  //   });
  // }

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
        return Container(
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.005,
              ),
              Flexible(
                child: GetSelectedsubjectsVideos.decodeDetails == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Container(
                          height: height * 0.78,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90)),
                          child: ListView.builder(
                              itemCount: GetSelectedsubjectsVideos
                                  .decodeDetails.length,
                              itemBuilder: (context, index) {
                                // Provider.of<GetVideoduration>(context,
                                //         listen: true)
                                //     .getduration(GetSelectedsubjectsVideos
                                //         .decodeDetails[index]['link']
                                //         .toString());
                                // l.e(GetSelectedsubjectsVideos
                                //     .decodeDetails[index]['link']
                                //     .toString());
                                // Provider.of<Videoduration>(context,
                                //         listen: false)
                                //     .getvideoduration((GetSelectedsubjectsVideos
                                //             .decodeDetails[index]['link'])
                                //         .toString());
                                // l.i(GetSelectedsubjectsVideos
                                //     .decodeDetails[index]['link']);

                                // you = YoutubePlayerController(
                                //   initialVideoId: YoutubePlayer.convertUrlToId(
                                //       GetSelectedsubjectsVideos
                                //           .decodeDetails[index]['link'])!,
                                //   flags: const YoutubePlayerFlags(
                                //     controlsVisibleAtStart: true,
                                //     hideControls: true,
                                //     autoPlay: false,
                                //     isLive: false,
                                //   ),
                                // );

                                return InkWell(
                                  child: Container(
                                      height: height * 0.18,
                                      width: width * 0.8,
                                      child: Card(
                                        elevation: 5,
                                        color: HexColor('#FFFFFF'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            GetSelectedsubjectsVideos
                                                                    .decodeDetails[
                                                                index]
                                                            ['subscribe'] ==
                                                        0 ||
                                                    Provider.of<GetPaymentDetails>(
                                                                context,
                                                                listen: false)
                                                            .statusCheckingPremiumOrFree ==
                                                        true
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Play(
                                                              link: GetSelectedsubjectsVideos
                                                                      .decodeDetails[
                                                                  index]['link'],
                                                            )))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PaymentDesign()));
                                          },
                                          child: Container(
                                            width: width,
                                            child: Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // SizedBox(
                                                //   width: width * 0.01,
                                                // ),
                                                Container(
                                                  height: height * 0.135,
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
                                                SizedBox(
                                                  width: width * 0.05,
                                                ),
                                                // Image.asset('assets/Carousel/image1.png'),
                                                Container(
                                                    width: width * 0.48,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                          GetSelectedsubjectsVideos
                                                              .decodeDetails[
                                                                  index]
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
                                                        SizedBox(
                                                          height:
                                                              height * 0.005,
                                                        ),
                                                        Text(
                                                          GetSelectedsubjectsVideos
                                                              .decodeDetails[
                                                                  index][
                                                                  'description']
                                                              .toString(),
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: HexColor(
                                                                  '#0A1C22')),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.002,
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
                                                                    0.005,
                                                              ),
                                                              customText(
                                                                  getText: GetSelectedsubjectsVideos
                                                                              .decodeDetails[
                                                                          index]
                                                                      ['link'])
                                                            ],
                                                          ),
                                                        ),
                                                        GetSelectedsubjectsVideos
                                                                            .decodeDetails[
                                                                        index][
                                                                    'subscribe'] ==
                                                                0
                                                            ? Text(
                                                                ' Free',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: HexColor(
                                                                        '#27AE60')),
                                                              )
                                                            : Text(
                                                                ' Premium',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: HexColor(
                                                                        '#F39C12')),
                                                              ),
                                                      ],
                                                    )),
                                                InkWell(
                                                  onTap: () {
                                                    Provider.of<WishList>(
                                                            context,
                                                            listen: false)
                                                        .checkingLikeAndUnlikeVideos(
                                                            context: context,
                                                            gettingVideoId:
                                                                GetSelectedsubjectsVideos
                                                                            .decodeDetails[
                                                                        index][
                                                                    'video_id']);
                                                  },
                                                  child: Icon(Icons.favorite,
                                                      color: Provider.of<
                                                                      WishList>(
                                                                  context,
                                                                  listen: true)
                                                              .youtubeVideoIdnew
                                                              .contains(GetSelectedsubjectsVideos
                                                                          .decodeDetails[
                                                                      index]
                                                                  ['video_id'])
                                                          ? Colors.pink
                                                          : Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                );
                              }),
                        ),
                      ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}

class customText extends StatefulWidget {
  final String? getText;
  customText({this.getText});

  @override
  State<customText> createState() => _customTextState();
}

class _customTextState extends State<customText> {
  YoutubeExplode yt = YoutubeExplode();
  String? dura;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gets();
  }

  gets() async {
    var k = await yt.videos.get(widget.getText);
    setState(() {
      dura = k.duration.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return dura == null
        ? Text(
            'waiting',
            style: TextStyle(fontSize: 9),
          )
        : Text(
            '${dura.toString().substring(2, 7)}',
            style: TextStyle(fontSize: 11, color: HexColor('#009688')),
          );
  }
}
