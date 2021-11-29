import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../play.dart';
import 'likeandunlikeapi.dart';
import 'paymentgetforvideosfreeorpremium.dart';

class Videowishlist extends StatefulWidget {
  const Videowishlist({Key? key}) : super(key: key);

  @override
  _VideowishlistState createState() => _VideowishlistState();
}

class _VideowishlistState extends State<Videowishlist> {
  @override
  // void initState() {
  //   super.initState();
  //   getWishlist();
  // }
  void initState() {
    super.initState();
    Provider.of<WishList>(context, listen: false).getWishlistnew();

    // functioncall();
  }

  // functioncall() async {
  //   await getWishlist();
  // }

  var search = TextEditingController();
  var decodeDetails, decodeDetailsData;
  String? token;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  bool isLoading = false;
  List<int> iconClick = [];
  final l = Logger();
  var wishlistDetails;

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
              top: height * 0.03,
            ),
            height: height,
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text('Favourites',
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
                  child:
                      Provider.of<WishList>(context, listen: true)
                              .youtubeVideoLink
                              .isEmpty
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
                              height: height,
                              width: width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90)),
                              child: ListView.builder(
                                  itemCount: Provider.of<WishList>(context,
                                          listen: false)
                                      .youtubeVideoLink
                                      .length,
                                  itemBuilder: (context, index) {
                                    var checkingTrueOrFalse = youtubevideoId!
                                        .contains(Provider.of<WishList>(context,
                                                    listen: false)
                                                .youtubeVideoLink[index]
                                            ['video_id']);
                                    // print('lllllllllllllllllllllll,  $s');
                                    // var you = YoutubePlayerController(
                                    //   initialVideoId: YoutubePlayer.convertUrlToId(
                                    //       Provider.of<WishList>(context,listen:false).youtubeVideoLink[index]['link'])!,
                                    //   flags: const YoutubePlayerFlags(
                                    //     controlsVisibleAtStart: true,
                                    //     hideControls: true,
                                    //     autoPlay: false,
                                    //     isLive: false,
                                    //   ),
                                    // );

                                    return InkWell(
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
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.01,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Provider.of<WishList>(context, listen: false)
                                                                              .youtubeVideoLink[
                                                                          index]
                                                                      [
                                                                      'subscribe'] ==
                                                                  0 ||
                                                              Provider.of<GetPaymentDetails>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .statusCheckingPremiumOrFree ==
                                                                  true
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Play(
                                                                            link:
                                                                                Provider.of<WishList>(context, listen: false).youtubeVideoLink[index]['link'],
                                                                          )))
                                                          : Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PaymentDesign()));
                                                    },
                                                    child: Padding(
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
                                                            'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(Provider.of<WishList>(context, listen: false).youtubeVideoLink[index]['link'])}/0.jpg',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Image.asset('assets/Carousel/image1.png'),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
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
                                                              // Text(Provider.of<WishList>(context,listen:false).youtubeVideoLink['data'][index]
                                                              //     ['link']),
                                                              Text(
                                                                Provider.of<WishList>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .youtubeVideoLink[
                                                                        index][
                                                                        'lesson']
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
                                                                Provider.of<WishList>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .youtubeVideoLink[
                                                                        index][
                                                                        'description']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                        getText:
                                                                            Provider.of<WishList>(context, listen: false).youtubeVideoLink[index]['link'])
                                                                  ],
                                                                ),
                                                              ),
                                                              Provider.of<WishList>(
                                                                              context,
                                                                              listen: false)
                                                                          .youtubeVideoLink[index]['subscribe'] ==
                                                                      0
                                                                  ? Text(
                                                                      'Free',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              HexColor('#27AE60')),
                                                                    )
                                                                  : Text(
                                                                      'Premium',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              HexColor('#F39C12')),
                                                                    ),
                                                            ])),
                                                  ),

                                                  InkWell(
                                                      onTap: () {
                                                        Provider.of<WishList>(
                                                                context,
                                                                listen: false)
                                                            .checkingLikeAndUnlikeVideos(
                                                                context:
                                                                    context,
                                                                gettingVideoId: Provider.of<
                                                                            WishList>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .youtubeVideoLink[index]['video_id']);
                                                      },
                                                      child: Icon(
                                                          Icons.favorite,
                                                          color: Colors.pink)),
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
}
