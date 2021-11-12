import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/ProfilePage/logout.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/view/navigation_button.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_edit_page.dart';

import 'profile_edit_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final l = Logger();
  var userName,
      standard,
      email,
      mobileNumber,
      profileImage,
      enrollmentNumber,
      school,
      academicYear;
  var imageFile;
  void initState() {
    super.initState();
    getUserName();
    print(29);
  }

  getUserName() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      print("${userDetails.length},25lineprofile");
      setState(() {
        userName = userDetails[0];
        email = userDetails[1];
        mobileNumber = userDetails[2];
        standard = userDetails[3];
        profileImage = userDetails[4];
        enrollmentNumber = userDetails[7];
        school = userDetails[8];
        academicYear = userDetails[9];
        print('$profileImage,32lineprofile');
        print(userName);
      });

      print(userDetails);
      print(28);
    });
  }

  chooseImage(source) async {
    var pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      print(pickedFile.path);
      var imageName = imageFile.path.split("/").last.toString();
    });
    return imageFile;
  }

  @override
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    // getUserName();
    // print(widget.indexnumber);
    print(43);
    Future<void> logOut() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('We will be redirected to login page.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the Dialog
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(); // Navigate to login
                },
              ),
            ],
          );
        },
      );
    }

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
                      child: InkWell(
                          onTap: () async {
                            var hello = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEditPage()));
                            if (hello != null) {
                              l.w(hello);
                              getUserName();
                            }
                          },
                          child: Image.asset('assets/ProfilePage/edit.png'))),
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
                                Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: profileImage == null ||
                                            profileImage == ""
                                        ? Container(
                                            height: (height - status) * 0.08,
                                            width: width * 0.15,
                                            color: Colors.redAccent[400],
                                            alignment: Alignment.center,
                                            child: Text(
                                              userName
                                                  .toString()
                                                  .substring(0, 1)
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                            ))
                                        : Image.network(profileImage),
                                  ),
                                  // Positioned(
                                  //   bottom: -4.0,
                                  //   right: -4.0,
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       showDialog(
                                  //           context: context,
                                  //           builder: (context) {
                                  //             return AlertDialog(
                                  //               title: Text(
                                  //                 'Select your choice',
                                  //                 style: GoogleFonts.poppins(),
                                  //               ),
                                  //               actions: [
                                  //                 TextButton(
                                  //                   onPressed: () async {
                                  //                     Navigator.pop(context);
                                  //                     var choosedCameraImage =
                                  //                         await chooseImage(
                                  //                             ImageSource
                                  //                                 .camera);
                                  //                     // postImage(choosedCameraImage);
                                  //                   },
                                  //                   child: Text(
                                  //                     'Camera',
                                  //                     style:
                                  //                         GoogleFonts.poppins(),
                                  //                   ),
                                  //                 ),
                                  //                 TextButton(
                                  //                     onPressed: () async {
                                  //                       Navigator.pop(context);
                                  //                       var choosedGalleryImage =
                                  //                           await chooseImage(
                                  //                               ImageSource
                                  //                                   .gallery);
                                  //                       // postImage(choosedGalleryImage);
                                  //                     },
                                  //                     child: Text('Gallery',
                                  //                         style: GoogleFonts
                                  //                             .poppins()))
                                  //               ],
                                  //             );
                                  //           });
                                  //     },
                                  //     child: Container(
                                  //       child: Icon(
                                  //         Icons.photo_camera,
                                  //         size: 25,
                                  //         color: Colors.teal.shade900,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ]),
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
                                      enrollmentNumber == null
                                          ? Text('')
                                          : Text(
                                              'EnrollmentNumber:$enrollmentNumber',
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
                                        // Image.asset(
                                        //   'assets/ProfilePage/school1.png',
                                        //   width: 20,
                                        //   height: 20,
                                        // ),
                                        Icon(
                                          Icons.school,
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        standard == null
                                            ? Text('')
                                            : Text(
                                                'class-$standard',
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
                                        // Image.asset(
                                        //   'assets/ProfilePage/school.png',
                                        //   width: 20,
                                        //   height: 20,
                                        // ),
                                        Icon(Icons.school_sharp),
                                        // Icon(Icons.),

                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Text(
                                          '$school',
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
                                          'Academic Year $academicYear',
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
                height: (height - status) * 0.11,
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
