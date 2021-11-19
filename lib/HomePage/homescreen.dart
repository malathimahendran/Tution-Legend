import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/Control/continuewating.dart';
import 'package:tutionmaster/HomePage/homeTestScreen.dart';

import 'package:tutionmaster/Payment%20Screens/paymentDesign.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';

import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/videos/likeandunlikeapi.dart';
import 'package:tutionmaster/videos/videomainscreen.dart';

import 'package:tutionmaster/videos/wishlist.dart';
import 'package:tutionmaster/view/navigation_button.dart';

import 'DRAWER FOLDER/drawer_page.dart';

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
      // var token = userDetails[5];

      // l.w(Provider.of<WishList>(context, listen: false).youtubeVideoId);
      // l.w(Provider.of<WishList>(context, listen: false).youtubeVideoLink);
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

    // return WillPopScope(
    // onWillPop: () {
    //   return Future.value(true);
    // },
    return WillPopScope(
      onWillPop: _page != 0
          ? () {
              l.e(_page);
              l.e('insideif');
              setState(() {
                _page = 0;
              });
              return Future.value(false);
            }
          : () {
              l.e('insideelse');
              l.e(_page);
              return Future.value(true);
            },
      child: SafeArea(
        child: Scaffold(
          key: HomeScreen.scaffoldkey1,
          resizeToAvoidBottomInset: false,
          drawer: Container(
            width: width * 0.75,
            height: height,
            child: DrawerPage(
              height: height,
              width: width,
              status: status,
              profileImage: profileImage,
              storeUserName: storeUserName,
              userName: userName,
              enrollmentNumber: enrollmentNumber,
            ),
          ),
          bottomNavigationBar: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/HomeScreenPage/homeScreenTab.png'),
                      fit: BoxFit.cover),
                ),
                width: double.infinity,
                height: 101.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(iconlist.length, (index) {
                    return GestureDetector(
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
                                    size: 20,
                                  )),
                              Text(
                                iconname[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              // Container(
              //   color: Colors.red,
              //   height: 50,
              //   margin: EdgeInsets.only(top: height * 0.7),
              //   child: CircleAvatar(
              //     radius: 25.0,
              //     child: Image.asset(
              //       'assets/HomeScreenPage/livevideo.png',
              //     ),
              //   ),
              // )
              Positioned(
                left: 0,
                right: 0,
                bottom: height * 0.03,
                child: CircleAvatar(
                  radius: 25.0,
                  child: Image.asset(
                    'assets/HomeScreenPage/livevideo.png',
                  ),
                ),
              )
            ],
          ),
          body: pages[_page],
        ),
        // ),
      ),
    );
  }
}
