import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/HomePage/homeTestScreen.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:tutionmaster/ProfilePage/logout.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/view/navigation_button.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_edit_page.dart';
import 'package:http/http.dart' as http;

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
      academicYear,
      googleId,
      token,
      decodeDetailsData,
      profileDetailsData,
      decodeDetails,
      amount,
      data,
      status,
      standardClass,
      subscribed_id;
  var imageFile;

  var subscribedDate;
  var endingDate, numberOfDaysLeft;
  void initState() {
    super.initState();
    // LogOutForAll.outTemporary(context);
    getUserName();
    getPlanDetails();
    getProfileDetails();
    print(29);
  }

  getProfileDetails() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      token = userDetails[5];
      print("$token" + "51 line");

      var url = Uri.parse(
          'http://www.cviacserver.tk/tuitionlegend/home/user_profile');

      var response = await http.get(url, headers: {'Authorization': token});
      profileDetailsData = json.decode(response.body);
      l.d(profileDetailsData);
      data = profileDetailsData['data'];
      l.w("$data,jjjjj");
      setState(() {
        standardClass = data[0]['class'];
        l.e("$standardClass,sdjfksdfjksdfjdkfdksfjk");
      });
      storingAllDetails(
        userName: userName,
        storeemail: email,
        standard: standard,
        phone: mobileNumber,
        profileImage: profileImage,
        token: token,
        standardFromGetApi: standardClass,
        googleId: googleId,
        enrollmentNumber: enrollmentNumber,
        school: school,
        academicYear: academicYear,
      );
    });
  }

  getPlanDetails() async {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      token = userDetails[5];
      print("$token" + "51 line");

      var url =
          Uri.parse('http://www.cviacserver.tk/tuitionlegend/home/get_payment');

      var response = await http.get(url, headers: {'Authorization': token});
      decodeDetailsData = json.decode(response.body);
      l.e(decodeDetailsData);
      var decode = response.body;
      l.e(decode);
      var result = decodeDetailsData['result'];
      l.wtf(result);
      if (result != null) {
        status = true;
        l.i("SDFSFSFSDF");
      } else {
        status = false;
        l.i("EEEE");
      }

      setState(() {
        subscribedDate =
            result[0]['subscribed_date'].toString().substring(0, 10);
        l.wtf(subscribedDate);
        endingDate = DateTime.parse(
            result[0]['ending_date'].toString().substring(0, 10));

        l.w(endingDate);
        // var bus = DateTime(int.parse(endingDate));

        var cu = DateTime.parse(DateTime.now().toString().substring(0, 10));
        setState(() {
          numberOfDaysLeft = endingDate.difference(cu).inDays;
        });
        l.wtf(numberOfDaysLeft);
        amount = result[0]['amount'];
        subscribed_id = result[0]['subscribed_id'];
        l.wtf(amount);
      });
    });
  }

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
        googleId = userDetails[6];
        token = userDetails[5];
        print('$profileImage,32lineprofile');
        print(userName);
      });
      print("$googleId,line 90 profilePage ");
      print(userDetails);
      print(28);
      l.wtf(googleId);
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
    l.e(standardClass);

    // getUserName();
    // print(widget.indexnumber);
    print(43);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: subscribed_id == null
            ? Center(child: CircularProgressIndicator())
            : Container(
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
                              style: TextStyle(
                                  color: HexColor('#F9F9F9'), fontSize: 20),
                            )),
                        Positioned(
                            top: (height - status) * 0.07,
                            left: width * 0.9,
                            child: InkWell(
                                onTap: () async {
                                  var hello = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileEditPage()));
                                  if (hello != null) {
                                    l.w(hello);
                                    getUserName();
                                  }
                                },
                                child: Image.asset(
                                    'assets/ProfilePage/edit.png'))),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: Row(
                                    children: [
                                      Stack(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: profileImage == null ||
                                                  profileImage == ""
                                              ? Container(
                                                  height:
                                                      (height - status) * 0.08,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30),
                                                  ))
                                              : Image.network(profileImage),
                                        ),
                                      ]),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$userName',
                                              style: TextStyle(
                                                  color: HexColor('#B91124'),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height:
                                                  ((height - status)) * 0.006,
                                            ),
                                            Text('Student',
                                                style: TextStyle(
                                                  color: HexColor('#848484'),
                                                  fontSize: 12,
                                                )),
                                            SizedBox(
                                              height:
                                                  ((height - status)) * 0.006,
                                            ),
                                            enrollmentNumber == 'null'
                                                ? Text("")
                                                : Text(
                                                    'EnrollmentNumber:$enrollmentNumber',
                                                    style: TextStyle(
                                                        color:
                                                            HexColor('#0AB4A4'),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                              Text(
                                                'class-$standardClass',
                                                style: TextStyle(
                                                    color: HexColor('#05534B'),
                                                    fontSize: 12),
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
                                              school == 'null'
                                                  ? Text("school:")
                                                  : Text(
                                                      '$school',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              '#05534B'),
                                                          fontSize: 11),
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
                                              academicYear == 'null'
                                                  ? Text("Academic Year :")
                                                  : Text(
                                                      'Academic Year : $academicYear',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              '#05534B'),
                                                          fontSize: 12),
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
                                          color: HexColor('#B91124'),
                                          fontSize: 13)),
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                                        style: TextStyle(
                                            color: HexColor('#023129'),
                                            fontSize: 12),
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.mail,
                                          color: HexColor('#023129'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      Text('$email',
                                          style: TextStyle(
                                              color: HexColor('#023129'),
                                              fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    googleId == "" || googleId == null
                        ? Container(
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
                                                color: HexColor('#B91124'),
                                                fontSize: 13)),
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
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: HexColor('#023129'),
                                                  fontSize: 30),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 240),
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
                          )
                        : Container(),
                    Container(
                      height: (height - status) * 0.16,
                      width: width * 0.9,
                      child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Text(
                                    'Plan Details',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: HexColor('#B91124'),
                                            fontSize: 13)),
                                  ),
                                ),
                              ),
                              amount == null
                                  ? Container(
                                      width: width * 0.9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Image.asset(
                                                    "assets/ProfilePage/year.png"),
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text("Free"),
                                            ],
                                          ),
                                          Container(
                                            width: width * 0.6,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentDesign()));
                                                },
                                                child: Text("Subscribe Now",
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.white),
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: width * 0.9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Image.asset(
                                                    "assets/ProfilePage/year.png"),
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Rs.$amount/Yearly",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Image.asset(
                                                  "assets/ProfilePage/calendar1.png",
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "$subscribedDate",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Image.asset(
                                                    "assets/ProfilePage/clock.png"),
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "$numberOfDaysLeft left",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                            ],
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
