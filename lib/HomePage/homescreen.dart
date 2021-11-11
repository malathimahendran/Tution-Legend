import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/HomePage/homeTestScreen.dart';

import 'package:tutionmaster/Payment%20Screens/paymentDesign.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';

import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/video/Videostream/videolist/firstscreen.dart';
import 'package:tutionmaster/video/Videostream/videolist/video_wishlist.dart';

class HomeScreen extends StatefulWidget {
  static var scaffoldkey1 = GlobalKey<ScaffoldState>();

  bool searchindex;
  HomeScreen(this.searchindex);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class IconAndText {
  IconData? icon;
  String? text;
  double? size;
  int? index;
  IconAndText({this.icon, this.text, this.size = 30.0, this.index});
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final l = Logger();
  List<IconAndText> iconAndText = [
    IconAndText(icon: Icons.home, text: 'Home', index: 0),
    IconAndText(icon: Icons.home, text: 'Home', index: 1),
    IconAndText(icon: Icons.home, text: 'Home', index: 2),
    IconAndText(icon: Icons.home, text: 'Home', index: 3),
  ];

  int selectedItem = 0;
  int _page = 0;
  var k;
  String? userName;
  var storeUserName, userEmail, profileImage, userMobileNo, enrollmentNumber;

  List<Widget> pages = [
    HomeTestScreen(),
    Searchvideo(),
    Videowishlist(),
    Profile(),
  ];
  List<IconData> iconlist = [
    Icons.home,
    Icons.video_collection,
    Icons.favorite,
    Icons.account_circle,
  ];
  List<String> iconname = ['Home', 'Videos', 'Wishlist', 'Profile'];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  void initState() {
    super.initState();

    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        storeUserName = userDetails[0];
        // userEmail = userDetails[1];
        // userMobileNo = userDetails[2];
        profileImage = userDetails[4];
        enrollmentNumber = userDetails[7];
        print("$userEmail,$userEmail");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchindex == true) {
      _page = 1;
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        key: HomeScreen.scaffoldkey1,
        resizeToAvoidBottomInset: false,
        drawer: Container(
          width: width * 0.75,
          height: height,
          child: Drawer(
              child: Column(children: [
            Container(
              color: HexColor('#009688'),
              height: height * 0.2,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: profileImage == null || profileImage == ""
                        ? Container(
                            height: (height - status) * 0.08,
                            width: width * 0.15,
                            color: Colors.redAccent[400],
                            alignment: Alignment.center,
                            child: Text(
                              userName.toString().substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ))
                        : Image.network(profileImage),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          storeUserName == null ? "" : storeUserName,
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                        Container(
                          child: Text('Student',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 12))),
                        ),
                        Container(
                          child: enrollmentNumber == null
                              ? Text('')
                              : Text('Enrollment no:$enrollmentNumber',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 13))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: width * 0.9,
              height: height * 0.6,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.65,
                    height: height * 0.075,
                    child: Card(
                      color: HexColor('#243665'),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(storeUserName == null ? "" : storeUserName,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 13)))
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentDesign()));
                    },
                    child: Container(
                      width: width * 0.65,
                      height: height * 0.075,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Icon(Icons.payment, color: HexColor('#3F3F3F')),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text('Payments',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 13)))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.65,
                    height: height * 0.075,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Icon(Icons.lock, color: HexColor('#3F3F3F')),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text('ChangePassword',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 13)))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.65,
                    height: height * 0.075,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Icon(
                          Icons.help,
                          color: HexColor('#3F3F3F'),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text('Help and Support',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 13)))
                      ],
                    ),
                  )
                ],
              ),
            )
          ])),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/HomeScreenPage/homeScreenTab.png'),
                  fit: BoxFit.cover)),
          width: double.infinity,
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(iconlist.length, (index) {
              return InkWell(
                onTap: () {
                  widget.searchindex = false;
                  l.w(_page);
                  setState(() {
                    _page = index;
                  });
                  l.w(_page);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 38.0),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    width: (width) * 1 / 4,
                    // color: Colors.black,
                    alignment: index == 1
                        ? Alignment.centerLeft
                        : index == 2
                            ? Alignment.centerRight
                            : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                            radius: 20.0,
                            backgroundColor: _page == index
                                ? Colors.white
                                : Colors.transparent,
                            child: Icon(
                              iconlist[index],
                              color: _page == index
                                  ? HexColor('#243665')
                                  : Colors.white,
                              size: 22,
                            )),
                        Text(
                          iconname[index],
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        body: pages[_page],
      ),
    );
  }
}
