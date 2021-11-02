import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/video/Videostream/videolist/secondscreen.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../play.dart';

class Searchvideo extends StatefulWidget {
  @override
  _SearchvideoState createState() => _SearchvideoState();
}

class _SearchvideoState extends State<Searchvideo> {
  var search = TextEditingController();
  var decodeDetailstest;
  var decodeDetails, token, decodeDetailsData;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];

  final l = Logger();
  var wishlistDetails;
  @override
  void initState() {
    super.initState();
    getUserSubjects();
    print('ammuammuammuammmu2222222');
  }

  getUserSubjects() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      String standardclass = userDetails[3];
      print(standardclass);
      print('nivetha');
      Provider.of<GetSubjectList>(context, listen: false)
          .getSubjectListApi(standardclass);
      print('papapapapapapapapapa');
    });
  }

  // var decodeDetails;
  // var standarsubject;
  @override
  Widget build(BuildContext context) {
    print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
          body: Consumer<GetSubjectList>(builder: (context, GetSubjectList, _) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/ProfilePage/mainbackground.png'),
          )),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
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
                  Container(
                    width: width * 0.9,
                    height: height * 0.15,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(131);
                            },
                            child: Container(
                              width: width * 0.4,
                              child: Card(
                                color: HexColor('#FFFFFF'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: ((height - status)) * 0.01,
                  ),
                  Column(
                    children: List.generate(GetSubjectList.subjectList.length,
                        (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Subjectnametext(
                            standardsubject: GetSubjectList.subjectList[index],
                          ),
                          SizedBox(
                            height: ((height - status)) * 0.01,
                          ),
                          // Consumer<GetSelectedsubjectsVideos>(
                          // builder: (context, GetSelectedsubjectsVideos, _) {

                          // widget.decodeDetails == null ?CircularProgressIndicator():
                          // HomeScreenVideos( Selectedsubjectname: GetSubjectList.subjectList[index],),
                          SubjectVideoslists(
                              standardsubject1:
                                  GetSubjectList.subjectList[index]),
                          // }),
                          SizedBox(
                            height: ((height - status)) * 0.01,
                          ),
                        ],
                      );
                      //   // var standarsubject=Provider.of<GetSubjectList>(context, listen: true).subjectList[index];
                      //   // var decodeDetails=Provider.of<GetSelectedsubjectsVideos>(context, listen: true).finaldecodelist[index];
                      // return SubjectVideosListWidget(standardsubject: Provider.of<GetSubjectList>(context, listen: true).subjectList[index] , decodeDetails:  Provider.of<GetSelectedsubjectsVideos>(context, listen: true).finaldecodelist[index] , );
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}

class Subjectnametext extends StatelessWidget {
  String standardsubject;
  Subjectnametext({required this.standardsubject});

  @override
  Widget build(BuildContext context) {
    print(standardsubject);
    print('maaalaaathiiiiiiii22222222222');
    return Text(
      standardsubject,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: HexColor('#0A1C22')),
    );
  }
}

class SubjectVideoslists extends StatefulWidget {
  String standardsubject1;

  SubjectVideoslists({required this.standardsubject1});

  @override
  State<SubjectVideoslists> createState() => _SubjectVideoslistsState();
}

class _SubjectVideoslistsState extends State<SubjectVideoslists> {
  var decodeDetails,
      token,
      decodeDetailsData,
      selectedSubs,
      decodeDetailsLength,
      decodeDetailsnew;

  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];

  final l = Logger();
  var wishlistDetails;
  searchApi(String Selectedsubjectname) async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      token = userDetails[5];
      print("$token" + "27linechapter");
      print(userDetails);
      print("28chapter");
      print(33);
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
        print(decodeDetailsnew.length);
      }
      decodeDetailsnew.add(decodeDetailsnew[0]);
      setState(() {
        decodeDetails = decodeDetailsnew;
      });

      print(decodeDetails);
      print("47chapteritem");
    });
  }

  getWishlist() async {
    var url =
        Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/wish_list');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
    });
    decodeDetailsData = json.decode(response.body);
    print(decodeDetailsData);
    l.i(decodeDetailsData);

    for (var i in decodeDetailsData['result'])
      youtubevideoId!.add(i['video_id']);
    l.e(youtubevideoId);
    setState(() {
      wishlistDetails = decodeDetailsData['result'];
    });

    print(decodeDetails);
    print("47chapteritem");
  }

  // @override
  void initState() {
    super.initState();
    searchApi(widget.standardsubject1);
    getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.standardsubject1);
    print('maaalaaathiiiiiiii');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: decodeDetails == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: (decodeDetails.length - 1) <= 2
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
                    var you = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                          decodeDetails[index]['link'])!,
                      flags: const YoutubePlayerFlags(
                        controlsVisibleAtStart: true,
                        hideControls: true,
                        autoPlay: false,
                        isLive: false,
                      ),
                    );

                    return InkWell(
                      onTap: () {
                        print(131);
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
                                                  widget.standardsubject1,
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
                                          child: YoutubePlayer(
                                            controller: you,
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
                                                        : Colors.teal)),
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

  likevideo(videoID) async {
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/like');
    var response = await http.post(url, body: {
      'video_id': videoID.toString()
    }, headers: {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
    });
    print(response.body);
  }

  unlikevideo(videoId) async {
    var url = Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/dislike');
    var response = await http.post(url, body: {
      'video_id': videoId.toString()
    }, headers: {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE3MmIyYTM0LWMwZTktNDIzOC1iMDZlLWVlODcwYmY2ZWJkNyIsImlhdCI6MTYzNTQwMzg0MSwiZXhwIjoxNjM3OTk1ODQxfQ.JD5RjsBcXbtjpblv02Ivxc0BhUKjuMiJzCjuP5e6kyw'
    });
    print(response.body);
  }
}
