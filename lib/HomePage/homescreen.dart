import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/HomePage/homeTestScreen.dart';
import 'package:tutionmaster/HomePage/second.dart';
import 'package:tutionmaster/HomePage/third.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';
import 'package:tutionmaster/Register/register.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/chapteritem.dart';
import 'package:tutionmaster/view/navigation_button.dart';

import 'first.dart';
import 'fourth.dart';

class HomeScreen extends StatefulWidget {

  bool searchindex;
  HomeScreen( this.searchindex);

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
  List<String> iconname = [
   'Home',
    'Videos',
    'Wishlist',
    'Profile'
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (widget.searchindex==true)
      {
        _page = 1;
      }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar:
            Container(
              width: double.infinity, height: 100.0,
              decoration: BoxDecoration(
              image: DecorationImage( image:AssetImage('assets/HomeScreenPage/homescreentab.png'), fit: BoxFit.cover ), ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(iconlist.length, (index)
              {
                 return InkWell(
                   onTap: (){
                     widget.searchindex= false;
                     setState(() {
                       _page=index;
                     });
                   },
                   child: Padding(
                     padding:  EdgeInsets.only(top: 38.0),
                     child: Container(
                       padding:EdgeInsets.only(bottom:2),
                       width:(width)*1/4,
                       // color: Colors.black,
                       alignment: index == 1 ?Alignment.centerLeft:index == 2 ?Alignment.centerRight:null,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: _page ==index? Colors.white :Colors.transparent ,
                                child: Icon( iconlist[index], color: _page ==index?Colors.pinkAccent: Colors.white, size: 22,)),
                            Text( iconname[index], style: TextStyle( color: Colors.white), )
                          ],
                        ),
                     ),
                   ),
                 );
              }),),
            ),
       body: pages[_page],
    );
  }
}
