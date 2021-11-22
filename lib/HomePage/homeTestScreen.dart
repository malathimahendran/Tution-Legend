import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutionmaster/Control/continuewating.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/videos/all_video_api.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
import 'homescreen.dart';

class HomeTestScreen extends StatefulWidget {
  HomeTestScreen({Key? key}) : super(key: key);
  @override
  _HomeTestScreenState createState() => _HomeTestScreenState();
}

class _HomeTestScreenState extends State<HomeTestScreen> {
  var userName;
  int ind = 0;
  getUserName() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        userName = userDetails[0];
        print(userName);
        print(36);
      });
      String standardclass = userDetails[3];
      print(standardclass);
      print('nivetha');
      Provider.of<GetSubjectList>(context, listen: false)
          .getSubjectListApi(standardclass);
      print(userDetails);
      print(28);
    });
  }

  int selectedIndex = 0;
  String selectedSubject = 'Recent';
  @override
  void initState() {
    super.initState();
    getUserName();
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("checkingGetstarted", true);
      },
    );
    Provider.of<SqliteLocalDatabase>(context, listen: false).getvideolist();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // v = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    return Scaffold(body: SafeArea(
      child: Consumer<GetSubjectList>(builder: (context, GetSubjectList, _) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/ProfilePage/mainbackground.png'),
          )),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.blue,
                  height: (height) * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          HomeScreen.scaffoldkey1.currentState!.openDrawer();
                        },
                        child: Image.asset(
                          'assets/HomeScreenPage/menu.png',
                          height: 20,
                        ),
                      ),
                      Text(
                        '$userName',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Allvideo()));
                          },
                          child: Icon(Icons.search))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: (height) * 0.25,
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/HomeScreenPage/homeScreenCard.png'),
                              fit: BoxFit.fill)),
                      height: (height) * 0.25,
                      width: width * 0.9,
                    ),
                    Positioned(
                      bottom: height * 0.1,
                      child: Text(
                        '       Start\n       Learning',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 30.0, 0.0),
                  child: Text(
                    'Recent Videos',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#0A1C22'))),
                  ),
                ),
                Container(
                  height: (height) * 0.4554,
                  child: HomeScreenVideos(
                    Selectedsubjectname: 'Recent',
                  ),
                ),
              ]),
        );
      }),
    ));
  }
}

class New extends StatelessWidget {
  const New({
    Key? key,
    required this.selectedSubject,
  }) : super(key: key);

  final String selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Text(selectedSubject);
  }
}
