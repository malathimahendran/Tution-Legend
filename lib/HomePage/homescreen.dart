import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/DrawerPage/drawer.dart';
import 'package:tutionmaster/HomePage/homeTestScreen.dart';
import 'package:tutionmaster/HomePage/second.dart';
import 'package:tutionmaster/HomePage/third.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';
import 'package:tutionmaster/Register/register.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/Videostream/chapteritem.dart';
import 'package:tutionmaster/view/navigation_button.dart';

import 'first.dart';
import 'fourth.dart';

class HomeScreen extends StatefulWidget {
  static var scaffoldkey1 = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedItem = 0;
  String? userName;
//  Stri userDetails = [];
  int _page = 0;
  List<Widget> pages = [
    HomeTestScreen(),
    Chapteritem(),
    Chapteritem(),
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        key: HomeScreen.scaffoldkey1,
        resizeToAvoidBottomInset: false,
        drawer: Flexible(
          child: Container(
            width: width * 0.7,
            height: height,
            child: Drawer(
                child: Column(children: [
              Container(
                color: HexColor('#FF4056'),
                width: width * 0.7,
                height: height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset('assets/ProfilePage/profile.png')],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Text(
                              'Sundar',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 75),
                          child: Text('Student',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 12))),
                        ),
                        Text('Enrollment no:2333',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 13))),
                      ],
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
                        color: HexColor('#FF4056'),
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
                            Text('Sundar',
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
                    Container(
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
                          Text('ChangPassword',
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
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/HomeScreenPage/homescreentab.png'),
                fit: BoxFit.cover),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(iconlist.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _page = index;
                  });
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
                                  ? Colors.pinkAccent
                                  : Colors.white,
                              size: 22,
                            )),
                        Text(
                          iconname[index],
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        // CurvedNavigationBar(
        //   height: 60.0,
        //   // key: _bottomNavigationKey,
        //   index: _page,
        //   items: <Widget>[
        //     NavigationBar(
        //       navigationbaricon: Icons.home,
        //       navigationbariconname: 'Home',
        //       iconIndex: 0,
        //       pageIndex: _page,
        //     ),
        //     NavigationBar(
        //       navigationbaricon: Icons.video_collection,
        //       navigationbariconname: 'Videos',
        //       iconIndex: 1,
        //       pageIndex: _page,
        //     ),
        //     NavigationBar(
        //       navigationbaricon: Icons.favorite,
        //       navigationbariconname: 'Wishlist',
        //       iconIndex: 2,
        //       pageIndex: _page,
        //     ),
        //     NavigationBar(
        //       navigationbaricon: Icons.account_circle,
        //       navigationbariconname: 'Profile',
        //       iconIndex: 3,
        //       pageIndex: _page,
        //     ),
        //   ],
        //   color: HexColor('#FF465C'),
        //   buttonBackgroundColor: HexColor('#FF465C'),
        //   backgroundColor: Colors.white,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: Duration(milliseconds: 500),
        //   onTap: (index) {
        //     setState(() {
        //       _page = index;
        //     });
        //   },
        //   letIndexChange: (index) => true,
        // ),
        // body:  HomeTestScreen(),
        body: pages[_page],
      ),
    );
  }
}
