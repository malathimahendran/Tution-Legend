import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/play.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'likeandunlikeapi.dart';
import 'paymentgetforvideosfreeorpremium.dart';

class Searchingg extends StatefulWidget {
  Searchingg({this.details, this.searchlist});
  final details;
  final searchlist;

  @override
  _SearchinggscreenState createState() => _SearchinggscreenState();
}

class _SearchinggscreenState extends State<Searchingg> {
  var search = TextEditingController();
  var decodeDetails,
      token,
      searchListAllData,
      decodeDetailsData,
      decodeDetailsnew,
      selectedSubs;
  final l = Logger();
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];
  List<int> apireceivedid = [];
  bool isList = false;
  bool isLoading = false;
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
      var url = Uri.parse('$searchApiCall$selectedParameterToSend');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token.toString(),
      });
      setState(() {
        searchListAllData = json.decode(response.body);
        decodeDetails = searchListAllData['data'];
      });
      l.e(searchListAllData);
    });
  }

  searchApi(String Selectedsubjectname) async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      selectedSubs = Selectedsubjectname.replaceAll(" ", "");
      var url = Uri.parse('$searchApiCall$selectedSubs');
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
                      if (search.text == '') {
                        print('hello');
                      } else {
                        gosearchapi(
                            gettingFromWhere: 'textFormField',
                            gettingWhatParameter: search.text);
                      }
                    },
                    controller: search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search videos',
                      suffixIcon: InkWell(
                        onTap: () {
                          if (search.text == '') {
                            print('hello');
                          } else {
                            gosearchapi(
                                gettingFromWhere: 'textFormField',
                                gettingWhatParameter: search.text);
                          }
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
                  child: searchListAllData == null || decodeDetails.length == 0
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
                                            // color: Colors.teal
                                            ),
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
                              itemCount: searchListAllData['data'].length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    print(131);
                                    searchListAllData['data'][index]
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
                                                builder: (context) => Play(
                                                      link: searchListAllData[
                                                              'data'][index]
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
                                                    left: 14),
                                                child: Container(
                                                  height: height * 0.12,
                                                  width: width * 0.23,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.network(
                                                      'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(searchListAllData['data'][index]['link'])}/0.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Image.asset('assets/Carousel/image1.png'),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
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
                                                                  getText: searchListAllData[
                                                                              'data']
                                                                          [
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
                                                        searchListAllData['data']
                                                                        [index][
                                                                    'subscribe'] ==
                                                                0
                                                            ? Text(
                                                                'Free',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: HexColor(
                                                                        '#27AE60')),
                                                              )
                                                            : Text(
                                                                'Premium',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
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
                                                    // checking(
                                                    //     link: decodeDetails[
                                                    //     index]['video_id']);
                                                    // Provider.of<WishList>(
                                                    //     context,
                                                    //     listen:
                                                    //     false).getwishvideoidlist();
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
