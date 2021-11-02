import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/getselectedsubject_videoslink.dart';
import 'package:tutionmaster/play.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreenVideos extends StatefulWidget {
  String Selectedsubjectname;
  HomeScreenVideos({required this.Selectedsubjectname});
  @override
  _HomeScreenVideosState createState() => _HomeScreenVideosState();
}

class _HomeScreenVideosState extends State<HomeScreenVideos> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetSelectedsubjectsVideos>(context, listen: false)
        .searchApi(widget.Selectedsubjectname);
  }

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
        return Column(
          children: [
            SizedBox(
              height: ((height - status)) * 0.04,
            ),
            Flexible(
              child: GetSelectedsubjectsVideos.decodeDetails == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: GetSelectedsubjectsVideos.decodeDetails.length,
                      itemBuilder: (context, index) {
                        var you = YoutubePlayerController(
                          initialVideoId: YoutubePlayer.convertUrlToId(
                              GetSelectedsubjectsVideos.decodeDetails[index]
                                  ['link'])!,
                          flags: const YoutubePlayerFlags(
                            controlsVisibleAtStart: true,
                            hideControls: true,
                            autoPlay: false,
                            isLive: false,
                          ),
                        );
                        print(GetSelectedsubjectsVideos
                            .decodeDetails[index]['link'].runtimeType);
                        print(109);
                        return InkWell(
                          onTap: () {
                            print(131);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Play(
                                          link: GetSelectedsubjectsVideos
                                              .decodeDetails[index]['link'],
                                        )));
                          },
                          child: Container(
                              height: (height) * 0.15,
                              width: width * 0.2,
                              child: Card(
                                color: HexColor('#FFFFFF'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: YoutubePlayer(
                                          controller: you,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Container(
                                            width: width * 0.58,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  GetSelectedsubjectsVideos
                                                      .decodeDetails[index]
                                                          ['subject']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          HexColor('#0A1C22')),
                                                ),
                                                Text(
                                                  GetSelectedsubjectsVideos
                                                      .decodeDetails[index]
                                                          ['lesson']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          HexColor('#0A1C22')),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Icon(
                                        Icons.favorite_outline_outlined,
                                        color: HexColor('#FF465C'),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        );
                      }),
            ),
            SizedBox(
              height: ((height - status)) * 0.02,
            ),
          ],
        );
      }),
    ));
  }
}
