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

import 'Home.dart';
import 'first.dart';
import 'fourth.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

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
  List<IconAndText> iconAndText = [
    IconAndText(icon: Icons.home, text: 'Home', index: 0),
    IconAndText(icon: Icons.home, text: 'Home', index: 1),
    IconAndText(icon: Icons.home, text: 'Home', index: 2),
    IconAndText(icon: Icons.home, text: 'Home', index: 3),
  ];

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
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        height: 75.0,
        // key: _bottomNavigationKey,
        index: _page,
        items: <Widget>[
          ...iconAndText.map((e) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_page != e.index)
                  SizedBox(
                    height: 16,
                  ),
                Icon(
                  e.icon,
                  size: e.size,
                ),
                if (_page != e.index) Text(e.text!),
              ],
            );
          }).toList()

          //     if (_page != 0)
          //       SizedBox(
          //         height: 16,
          //       ),
          //     Icon(
          //       Icons.home,
          //       size: 30,
          //     ),
          //     if (_page != 0) Text('Home'),
          //   ],
          // ),
          // Icon(
          //   Icons.home,
          //   size: 30,
          // ),
          // Icon(
          //   Icons.home,
          //   size: 30,
          // ),
          // Icon(
          //   Icons.home,
          //   size: 30,
          // ),
          // NavigationBar(

          //   navigationbaricon: Icons.home,
          //   navigationbariconname: 'Home',
          //   iconIndex: 0,
          //   pageIndex: _page,
          // ),
          // NavigationBar(
          //   navigationbaricon: Icons.video_collection,
          //   navigationbariconname: 'Videos',
          //   iconIndex: 1,
          //   pageIndex: _page,
          // ),
          // NavigationBar(
          //   navigationbaricon: Icons.favorite,
          //   navigationbariconname: 'Wishlist',
          //   iconIndex: 2,
          //   pageIndex: _page,
          // ),
          // NavigationBar(
          //   navigationbaricon: Icons.account_circle,
          //   navigationbariconname: 'Profile',
          //   iconIndex: 3,
          //   pageIndex: _page,
          // ),
        ],
        color: HexColor('#FF465C'),
        buttonBackgroundColor: HexColor('#FF465C'),
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        // letIndexChange: (index) => true,
      ),
      body: pages[_page],
    );
  }
}
// class NavigationBar extends StatelessWidget {
//   IconData navigationbaricon;
//   String navigationbariconname;
//   NavigationBar(
//       {required this.navigationbaricon, required this.navigationbariconname});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: Column(
//         children: [
//           Icon(
//             navigationbaricon,
//             size: 25,
//             color: Colors.white,
//           ),
//           // SizedBox(height: 5.0),
//           Text(navigationbariconname,
//               style: TextStyle(
//                 color: Colors.white,
//               )),
//         ],
//       ),
//     );
//   }
// }
