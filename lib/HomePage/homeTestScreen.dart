import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Videostream/chapteritem.dart';
import 'package:tutionmaster/view/HomeScreen_videoDisplay.dart';
// import 'package:tutionmaster/chapteritem.dart';`

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
        print(37);

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
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    return Scaffold(body: SafeArea(
      child: Consumer<GetSubjectList>(builder: (context, GetSubjectList, _) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/ProfilePage/mainbackground.png'),
          )),
          child: Column(children: [
            Container(
              // color: Colors.blue,
              height: (height - (status + bottom)) * 0.06,
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
                                builder: (context) => HomeScreen(true)));
                      },
                      child: Icon(Icons.search))
                ],
              ),
            ),
            Container(
              // color: Colors.red,
              height: (height - (status + bottom)) * 0.25,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/HomeScreenPage/homecard.png'),
                  )),
                  height: (height - status) * 0.25,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GetSubjectList.subjectList == null
                  ? CircularProgressIndicator()
                  : Row(
                      children: List.generate(GetSubjectList.subjectList.length,
                          (index) {
                        return InkWell(
                          onTap: () {
                            selectedSubject = GetSubjectList.subjectList[index];
                            setState(() {
                              selectedIndex = index;
                            });
                            print(selectedSubject);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: index == selectedIndex
                                    ? Colors.green
                                    : Colors.grey[350],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  GetSubjectList.subjectList[index],
                                  style: TextStyle(
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
            ),
            Container(
              height: (height - (status + bottom)) * 0.50,
              color: Colors.green,

              child: HomeScreenVideos(
                Selectedsubjectname: selectedSubject,
              ),
              // New(selectedSubject: selectedSubject)
              // HomeScreenVideos( Selectedsubjectname: selectedSubject,),
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
