import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/Control/getdata.dart';
import 'package:tutionmaster/DrawerPage/drawer.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Videostream/chapteritem.dart';

class HomeTestScreen extends StatefulWidget {
  HomeTestScreen({Key? key}) : super(key: key);

  @override
  _HomeTestScreenState createState() => _HomeTestScreenState();
}

class _HomeTestScreenState extends State<HomeTestScreen> {
  var userName;
  // var scaffoldKey = GlobalKey<ScaffoldState>();

  getUserName() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        userName = userDetails[0];
        print(userName);
      });
      String standardclass = userDetails[3];
      print(standardclass);
      print('nivetha');
      Provider.of<GetSubjectList>(context, listen: false)
          .getSubjectListApi(standardclass);

      // getSubjectListApi(standard);
      print(userDetails);
      // setState(() {
      //   selectedSubject =
      //       Provider.of<GetSubjectList>(context, listen: true).subjectList[0];
      // });
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
    return SafeArea(
      child: Scaffold(
          // key: scaffoldKey,

          body: SafeArea(
        child: Container(
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
                                  builder: (context) => Chapteritem()));
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
                  // Positioned(
                  //   bottom: height * 0.02,
                  //   left: width * 0.07,
                  //   child: Container(
                  //     height: height * 0.05,
                  //     width: width * 0.6,
                  //     child: TextFormField(
                  //       decoration: InputDecoration(
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         hintText: 'What you want to learn',
                  //         suffixIcon: Icon(
                  //           Icons.search,
                  //           color: Colors.red,
                  //         ),
                  //         // icon: Icon(Icons.search),
                  //         hintStyle: GoogleFonts.poppins(
                  //             textStyle: TextStyle(
                  //                 fontSize: 11, color: HexColor('#7B7777'))),
                  //         // prefixIcon: icon,
                  //         enabledBorder: OutlineInputBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10.0)),
                  //             borderSide:
                  //                 BorderSide(color: Colors.grey.shade300)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10.0)),
                  //             borderSide: BorderSide(color: HexColor('#27DEBF'))),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ]),
              ),
              Consumer<GetSubjectList>(builder: (context, GetSubjectList, _) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetSubjectList.subjectList == null
                      ? CircularProgressIndicator()
                      : Row(
                          children: List.generate(
                              GetSubjectList.subjectList.length, (index) {
                            return InkWell(
                              onTap: () {
                                selectedSubject =
                                    GetSubjectList.subjectList[index];
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
                );
              }),
              Container(
                height: (height - (status + bottom)) * 0.47,
                child: Center(child: Text(selectedSubject)),
              ),
            ])),
      )),
    );
  }
}
