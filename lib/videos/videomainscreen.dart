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
import 'package:tutionmaster/videos/all_video_api.dart';
import 'package:tutionmaster/videos/searchvideo.dart';
import 'package:search_widget/search_widget.dart';
import 'package:tutionmaster/videos/secondscreen.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../play.dart';
import 'likeandunlikeapi.dart';

class Searchvideo extends StatefulWidget {
  @override
  _SearchvideoState createState() => _SearchvideoState();
}

class _SearchvideoState extends State<Searchvideo> {
  var search = TextEditingController();
  var decodeDetailstest;
  var decodeDetails, token, decodeDetailsData, decodeDetailsnew;
  List<int>? youtubevideoId = [];
  bool isIconClicked = false;
  List<int> iconClick = [];

  final l = Logger();
  var wishlistDetails;
  @override
  void initState() {
    super.initState();
    getUserSubjects();
  }

  getUserSubjects() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      String standardclass = userDetails[3];
      print(standardclass);
      print('nivetha');
      Provider.of<GetSubjectList>(context, listen: false)
          .getSubjectListApi(standardclass);
    });
  }

  @override
  Widget build(BuildContext context) {
    l.w('here is the start of the widget');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // ignore: non_constant_identifier_names
          body: Consumer<GetSubjectList>(builder: (context, GetSubjectList, _) {
            return Container(
              width: width,
              height: height,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage('assets/ProfilePage/mainbackground.png'),
              // )),
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
                            onFieldSubmitted: (value) async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Searchingg(
                                            searchlist: search.text,
                                          )));
                            },
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
                                      fontSize: 11,
                                      color: HexColor('#7B7777'))),
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
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Continue Watching',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#0A1C22')),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Allvideo()));
                                },
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      GetSubjectList.subjectList == null
                          ? CircularProgressIndicator()
                          : Column(
                              children: List.generate(
                                  GetSubjectList.subjectList.length, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Subjectnametext(
                                      standardsubject:
                                          GetSubjectList.subjectList[index],
                                    ),
                                    SizedBox(
                                      height: ((height - status)) * 0.01,
                                    ),
                                    SubjectVideoslists(
                                        standardsubject1:
                                            GetSubjectList.subjectList[index]),
                                    // }),
                                    SizedBox(
                                      height: ((height - status)) * 0.01,
                                    ),
                                  ],
                                );
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
  var selectedsubject,
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
        selectedsubject = decodeDetailsnew;
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
      child: selectedsubject == null
          ? Center(
              child: Visibility(
                  visible: false, child: CircularProgressIndicator()))
          : Container(
              height: (selectedsubject.length - 1) < 2
                  ? ((height) * 0.3) / 2
                  : height * 0.3,
              width: width * 0.9,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: selectedsubject.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: selectedsubject.length <= 2?1:2,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    // var s = Provider.of<WishList>(context, listen: true)
                    //         .onlyVideoId ==
                    //     (selectedsubjectnew[index]['video_id']);
                    // l.w(s);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Play(
                                      link: selectedsubject[index]['link'],
                                    )));
                      },
                      child: index >= (selectedsubject.length - 1)
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
                                            'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(selectedsubject[index]['link'])}/0.jpg',
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
                                                child: Icon(
                                                  Icons.favorite,
                                                  // color: Provider.of<
                                                  //                 WishList>(
                                                  //             context,
                                                  //             listen: true)
                                                  //         .onlyVideoId
                                                  //         .contains(
                                                  //             decodeDetailsnew[
                                                  //                 index])
                                                  //     //         .onlyVideoId
                                                  //     ? Colors.pink
                                                  //     : Colors.grey)),
                                                ),
                                              )),
                                          Text(
                                            selectedsubject[index]['subject']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: HexColor('#0A1C22')),
                                          ),
                                          Text(
                                            selectedsubject[index]['lesson']
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
