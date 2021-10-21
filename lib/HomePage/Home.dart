import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

import 'first.dart';
import 'fourth.dart';
import 'second.dart';
import 'third.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? tabController;
  var userName;
  @override
  void initState() {
    super.initState();
    getUserName();
    tabController = TabController(length: 6, vsync: this);
    print(29);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  getUserName() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        userName = userDetails[0];
        print(userName);
      });

      print(userDetails);
      print(28);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    print("$bottom" + "54");

    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/ProfilePage/mainbackground.png'),
        )),
        child: Column(
          children: [
            Container(
              // color: Colors.blue,
              height: (height - (status + bottom)) * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/HomeScreenPage/menu.png',
                    height: 20,
                  ),
                  Text(
                    '$userName',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Icon(Icons.person)
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
                  bottom: height * 0.12,
                  child: Text(
                    '       Start\n       Learning',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white)),
                  ),
                ),
                Positioned(
                  bottom: height * 0.02,
                  left: width * 0.07,
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.6,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'What you want to learn',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        // icon: Icon(Icons.search),
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 11, color: HexColor('#7B7777'))),
                        // prefixIcon: icon,
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: HexColor('#27DEBF'))),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Stack(
              children: [
                Container(
                  height: height * 0.07,
                  width: width,
                  // color: Colors.pink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: height * 0.07,
                          width: (width * 1 / 6) - 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: height * 0.07,
                          width: (width * 1 / 6) - 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: height * 0.07,
                          width: (width * 1 / 6) - 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: height * 0.07,
                          width: (width * 1 / 6) - 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: height * 0.07,
                          width: (width * 1 / 6) - 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: height * 0.07,
                          width: (width * 1 / 6) - 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.07,
                  width: width,
                  child: TabBar(
                    // automaticIndicatorColorAdjustment: true,
                    isScrollable: false,
                    // indicatorColor: Colors.orange,
                    labelStyle: const TextStyle(),
                    unselectedLabelColor: Colors.black,
                    enableFeedback: true,
                    indicatorPadding: const EdgeInsets.all(10.0),
                    indicator: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelColor: Colors.white,
                    // indicatorSize: TabBarIndicatorSize.label,
                    controller: tabController,
                    mouseCursor: SystemMouseCursors.basic,
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.focused)) {
                        return Colors.transparent;
                      } else if (states.contains(MaterialState.disabled)) {
                        return Colors.transparent;
                      } else if (states.contains(MaterialState.hovered)) {
                        return Colors.transparent;
                      } else if (states.contains(MaterialState.selected)) {
                        return Colors.transparent;
                      } else if (states.contains(MaterialState.pressed)) {
                        return Colors.transparent;
                      } else {
                        return Colors.transparent;
                      }
                    }),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      const Text('Recent'),
                      const Text('All'),
                      const Text('Maths'),
                      const Text('Science'),
                      Text('Science'),
                      Text('Science'),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: height * 0.47,
              width: width,
              child: TabBarView(
                controller: tabController,
                children: [First(), Second(), Third(), Fourth()],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
