import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../play.dart';
import 'likeandunlikeapi.dart';

class Videowishlist extends StatefulWidget {
  const Videowishlist({Key? key}) : super(key: key);

  @override
  _VideowishlistState createState() => _VideowishlistState();
}

class _VideowishlistState extends State<Videowishlist> {
  @override
  void initState() {
    super.initState();
  }

  var search = TextEditingController();
  var decodeDetails, decodeDetailsData;
  String? token;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
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
                    onFieldSubmitted: (value) {},
                    controller: search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search videos',
                      suffixIcon: InkWell(
                        onTap: () {},
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
                  child: Provider.of<WishList>(context, listen: true)
                          .youtubeVideoLink
                          .isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: height,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90)),
                          child: ListView.builder(
                              itemCount:
                                  Provider.of<WishList>(context, listen: false)
                                      .youtubeVideoLink
                                      .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Container(
                                      height: (height) * 0.12,
                                      width: width,
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
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder:
                                                  //             (context) => Play(
                                                  //                   link: Provider.of<WishList>(
                                                  //                           context,
                                                  //                           listen:
                                                  //                               false)
                                                  //                       .youtubeVideoLink[index]['link'],
                                                  //                 )));
                                                },
                                                child: Container(
                                                  width: width * 0.2,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.network(
                                                      'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(Provider.of<WishList>(context, listen: false).youtubeVideoLink[index]['link'])}/0.jpg',
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
                                                    width: width * 0.58,
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
                                                                  listen: false)
                                                              .youtubeVideoLink[
                                                                  index]
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
                                                          Provider.of<WishList>(
                                                                  context,
                                                                  listen: false)
                                                              .youtubeVideoLink[
                                                                  index]
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
                                                            gettingVideoId: Provider.of<
                                                                            WishList>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .youtubeVideoLink[
                                                                index]['video_id']);
                                                  },
                                                  child: Icon(Icons.favorite,
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
