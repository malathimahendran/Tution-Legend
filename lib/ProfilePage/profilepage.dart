import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tutionmaster/ProfilePage/logout.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/view/navigation_button.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userName, standard, email, mobileNumber;
  void initState() {
    super.initState();
    getUserName();
    print(29);
  }

  getUserName() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        userName = userDetails[0];
        email = userDetails[1];
        mobileNumber = userDetails[2];
        standard = userDetails[3];
        print(userName);
      });

      print(userDetails);
      print(28);
    });
  }

  @override
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    // print(widget.indexnumber);
    print(43);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: CurvedNavigationBar(
        //   key: _bottomNavigationKey,
        //   items: <Widget>[
        //     NavigationBar(
        //         navigationbaricon: Icons.home, navigationbariconname: 'Home'),
        //     NavigationBar(
        //         navigationbaricon: Icons.video_collection,
        //         navigationbariconname: 'Videos'),
        //     NavigationBar(
        //         navigationbaricon: Icons.favorite,
        //         navigationbariconname: 'Wishlist'),
        //     NavigationBar(
        //         navigationbaricon: Icons.account_circle,
        //         navigationbariconname: 'Profile'),
        //   ],
        //   color: Colors.pinkAccent,
        //   buttonBackgroundColor: Colors.pinkAccent,
        //   backgroundColor: Colors.white,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: Duration(milliseconds: 500),
        //   onTap: (index) {
        //     if (index == 3) {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => Profile()));
        //     }
        //     // setState(() {
        //     //   _page = index;
        //     // });
        //   },
        //   letIndexChange: (index) => true,
        // ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(
                      'assets/ProfilePage/mainbackground.png'))),
          height: height,
          width: width,
          child: Column(
            children: [
              Stack(
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                overflow: Overflow.visible,

                children: [
                  Container(
                    height: (height - status) * 0.30,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(
                                'assets/LoginPage/logintop.png'),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                      top: (height - status) * 0.03,
                      left: width * 0.3,
                      child: Text(
                        'Student Profile',
                        style:
                            TextStyle(color: HexColor('#F9F9F9'), fontSize: 20),
                      )),
                  Positioned(
                      top: (height - status) * 0.07,
                      left: width * 0.9,
                      child: Image.asset('assets/ProfilePage/edit.png')),
                  Positioned(
                    top: (height - status) * 0.10,
                    left: width * 0.05,
                    child: Container(
                      height: (height - status) * 0.25,
                      width: width * 0.9,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: HexColor('#FFFFFF'),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                      'assets/ProfilePage/profile.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$userName',
                                        style: TextStyle(
                                            color: HexColor('#B91124'),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: ((height - status)) * 0.006,
                                      ),
                                      Text('Student',
                                          style: TextStyle(
                                            color: HexColor('#848484'),
                                            fontSize: 15,
                                          )),
                                      SizedBox(
                                        height: ((height - status)) * 0.006,
                                      ),
                                      Text('',
                                          style: TextStyle(
                                              color: HexColor('#0AB4A4'),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )
                              ],
                            )),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/ProfilePage/school1.png'),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Text(
                                          '$standard',
                                          style: TextStyle(
                                              color: HexColor('#05534B'),
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/ProfilePage/school.png'),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                              color: HexColor('#05534B'),
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/ProfilePage/calender.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Text(
                                          '',
                                          style: TextStyle(
                                              color: HexColor('#05534B'),
                                              fontSize: 13),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ((height - status)) * 0.05,
              ),
              Container(
                height: (height - status) * 0.16,
                width: width * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: HexColor('#FFFFFF'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Contact Details',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: HexColor('#B91124'), fontSize: 13)),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.phone_android,
                                    color: HexColor('#023129'),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Text(
                                  '$mobileNumber',
                                  style: TextStyle(color: HexColor('#023129')),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.mail,
                                    color: HexColor('#023129'),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Text('$email',
                                    style:
                                        TextStyle(color: HexColor('#023129'))),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: (height - status) * 0.12,
                width: width * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: HexColor('#FFFFFF'),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Password',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: HexColor('#B91124'), fontSize: 13)),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                color: HexColor('#023129'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: HexColor('#023129'), fontSize: 30),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 240),
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: HexColor('#023129'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //
                  ),
                ),
              ),
              Container(
                height: (height - status) * 0.13,
                width: width * 0.9,
                child: Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'Plan Details',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#B91124'), fontSize: 13)),
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: HexColor('#FFFFFF')),
              ),
              InkWell(
                onTap: () {
                  LogOutForAll.outTemporary(context);
                },
                child: Container(
                  height: (height - status) * 0.08,
                  width: width * 0.9,
                  child: Card(
                      child: Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: HexColor('#023129'),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                'Logout',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: HexColor('#B91124'),
                                        fontSize: 13)),
                              ),
                            ],
                          )),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: HexColor('#FFFFFF')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
