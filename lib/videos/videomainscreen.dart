import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/continuewating.dart';
import 'package:tutionmaster/Control/getdata.dart';

import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/videos/searchvideo.dart';
// import 'package:search_widget/search_widget.dart';
import 'package:tutionmaster/videos/secondscreen.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../play.dart';
import '../playcontinuewatching.dart';
import 'likeandunlikeapi.dart';

class Searchvideo extends StatefulWidget {
  @override
  _SearchvideoState createState() => _SearchvideoState();
}

class _SearchvideoState extends State<Searchvideo> {
  var search = TextEditingController();
  var decodeDetailstest;
  var decodeDetails,
      token,
      decodeDetailsData,
      decodeDetailsnew,
      continuewatchlist;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];

  final l = Logger();
  var wishlistDetails;
  @override
  void initState() {
    super.initState();
    getUserSubjects();
    Provider.of<SqliteLocalDatabase>(context, listen: false).getvideolist();
  }

  getUserSubjects() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      String standardclass = userDetails[3];
      print(standardclass);
      print('nivetha');
      Provider.of<GetSubjectList>(context, listen: false)
          .getSubjectListApi(standardclass);
      // setState(() {

      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   continuewatchlist=Provider.of<SqliteLocalDatabase>(context, listen: true).wathedvideolist;
    // });
    l.w('here is the start of the widget');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Consumer<GetSubjectList>(builder: (context, GetSubjectList, _) {
            return Container(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.9,
                        child: TextFormField(
                          // textInputAction: TextInputAction.search,
                          // onFieldSubmitted: (value) async {
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) => SubjectVideoslists(
                          //   //               standardsubject1: '',
                          //   //             )));
                          // },
                          controller: search,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search videos',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                l.w('inside line 126 , in inkwell searchingg');
                                // var n = await gosearchapi();
                                // l.wtf(n);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Searchingg(
                                              searchlist: search.text,
                                            )));
                              },
                              color: Colors.red,
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
                    ),
                    Container(
                      height: height * 0.76,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ((height - status)) * 0.03,
                              ),
                              Text(
                                'Continue Watching',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#0A1C22')),
                              ),
                              SizedBox(
                                height: ((height - status)) * 0.01,
                              ),
                              Provider.of<SqliteLocalDatabase>(context,
                                                  listen: true)
                                              .wathedvideolist ==
                                          null ||
                                      Provider.of<SqliteLocalDatabase>(context,
                                              listen: true)
                                          .wathedvideolist
                                          .isEmpty
                                  ? Text('no videos watched')
                                  : Container(
                                      width: width * 0.9,
                                      height: height * 0.15,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              Provider.of<SqliteLocalDatabase>(
                                                              context,
                                                              listen: true)
                                                          .wathedvideolist
                                                          .length >
                                                      5
                                                  ? 5
                                                  : Provider.of<
                                                              SqliteLocalDatabase>(
                                                          context,
                                                          listen: true)
                                                      .wathedvideolist
                                                      .length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                print(Provider.of<
                                                            SqliteLocalDatabase>(
                                                        context,
                                                        listen: false)
                                                    .wathedvideolist[index]
                                                    .videoid);
                                                print(
                                                    'ggggggggrrrrrrrrrrrrrrrrrrrrrrrrrraaaaaaaaaaaaaaaaaaaaaa');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Playcontinue(
                                                            videoid1: Provider.of<
                                                                        SqliteLocalDatabase>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .wathedvideolist[
                                                                    index]
                                                                .videoid,
                                                            durationwatched: Provider.of<
                                                                        SqliteLocalDatabase>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .wathedvideolist[
                                                                    index]
                                                                .duration)));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: width * 0.4,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image.network(
                                                          'https://img.youtube.com/vi/${Provider.of<SqliteLocalDatabase>(context, listen: true).wathedvideolist[index].videoid}/0.jpg',
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                              SizedBox(
                                height: ((height - status)) * 0.01,
                              ),
                              GetSubjectList.subjectList == null
                                  ? CircularProgressIndicator()
                                  : Column(
                                      children: List.generate(
                                          GetSubjectList.subjectList.length,
                                          (index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Subjectnametext(
                                              standardsubject: GetSubjectList
                                                  .subjectList[index],
                                            ),
                                            SizedBox(
                                              height:
                                                  ((height - status)) * 0.01,
                                            ),
                                            SubjectVideoslists(
                                                standardsubject1: GetSubjectList
                                                    .subjectList[index]),
                                            // }),
                                            SizedBox(
                                              height:
                                                  ((height - status)) * 0.01,
                                            ),
                                          ],
                                        );
                                      }),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //   image: AssetImage('assets/ProfilePage/mainbackground.png'),
                // )),

                );
          })),
    );
  }
}

class Subjectnametext extends StatelessWidget {
  String? standardsubject;
  Subjectnametext({this.standardsubject});
  final l = Logger();
  @override
  Widget build(BuildContext context) {
    l.wtf(standardsubject);
    return Text(
      standardsubject ?? "how are you my friend",
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: HexColor('#0A1C22')),
    );
  }
}

class SubjectVideoslists extends StatefulWidget {
  String? standardsubject1;

  SubjectVideoslists({this.standardsubject1});

  @override
  State<SubjectVideoslists> createState() => _SubjectVideoslistsState();
}

class _SubjectVideoslistsState extends State<SubjectVideoslists> {
  YoutubePlayerController? youtubePlayerController;
  var decodeDetails,
      token,
      decodeDetailsData,
      selectedSubs,
      decodeDetailsLength,
      decodeDetailsnew;
  var search = TextEditingController();
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];

  final l = Logger();
  var wishlistDetails;

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
      if (decodeDetailsnew.length > 3) {
        decodeDetailsnew.removeRange(3, (decodeDetailsnew.length));
      }
      decodeDetailsnew.add(decodeDetailsnew[0]);
      setState(() {
        decodeDetails = decodeDetailsnew;
      });
    });
  }

  getWishlist() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];

      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      });
      decodeDetailsData = json.decode(response.body);

      for (var i in decodeDetailsData['result'])
        youtubevideoId!.add(i['video_id']);

      setState(() {
        wishlistDetails = decodeDetailsData['result'];
      });
    });
  }

  void initState() {
    super.initState();
    functioncall();
  }

  functioncall() async {
    await searchApi(widget.standardsubject1!);

    await getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.standardsubject1);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: decodeDetails == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: (decodeDetails.length - 1) < 2
                  ? ((height) * 0.3) / 2
                  : height * 0.3,
              width: width * 0.9,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: decodeDetails.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: decodeDetails.length <= 2?1:2,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    var s = youtubevideoId!
                        .contains(decodeDetailsnew[index]['video_id']);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Play(
                                      link: decodeDetails[index]['link'],
                                    )));
                      },
                      child: index >= (decodeDetails.length - 1)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Secondscreen(
                                              Selectedsubjectname:
                                                  widget.standardsubject1!,
                                            )));
                              },
                              child: Container(
                                  height: (height) * 0.15,
                                  width: width * 0.1,
                                  child: Card(
                                    color: HexColor('#FFFFFF'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                        child: Text('View more',
                                            style: TextStyle(
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ))),
                                  )),
                            )
                          : Container(
                              height: (height) * 0.15,
                              width: width * 0.1,
                              child: Card(
                                color: HexColor('#FFFFFF'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 8.0),
                                      child: Container(
                                        width: width * 0.17,
                                        height: height * 0.08,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(decodeDetails[index]['link'])}/0.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50.0, top: 10.0),
                                            child: InkWell(
                                                onTap: () {
                                                  checking(
                                                      link: decodeDetailsnew[
                                                          index]['video_id']);
                                                },
                                                child: Icon(Icons.favorite,
                                                    color: s
                                                        ? Colors.pink
                                                        : Colors.grey)),
                                          ),
                                          Text(
                                            decodeDetails[index]['subject']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: HexColor('#0A1C22')),
                                          ),
                                          Text(
                                            decodeDetails[index]['lesson']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: HexColor('#0A1C22')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                    );
                  }),
            ),
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
