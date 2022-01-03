import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/HomePage/changepassword.dart';
import 'package:tutionmaster/HomePage/homeTestScreen.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';
import 'package:tutionmaster/ProfilePage/logout.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/paymentPlansApiIsExpiredOrNot/getPlanDetailsApi.dart';
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
      // decodeDetailsData,
      profileDetailsData,
      decodeDetails,
      // result,
      // amount,
      data,
      // status,
      standardClass;
  // subscribed_id;
  var board;
  var imageFile;
  bool isLoading = false;
  // var subscribedDate;
  // var endingDate, numberOfDaysLeft;
  void initState() {
    super.initState();
    // LogOutForAll.outTemporary(context);
    getUserName();
    Provider.of<GetPlanDetails>(context, listen: false).getPlanDetails();
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
      l.v("$profileDetailsData,profileDetailsGetData");

      data = profileDetailsData['data'];
      l.w("$data,jjjjj");
      setState(() {
        standardClass = data[0]['class'];
        l.e("$standardClass,sdjfksdfjksdfjdkfdksfjk");
        board = data[0]['board_id'];
        l.v(board);
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

  // getPlanDetails() async {
  //   Shared().shared().then((value) async {
  //     var userDetails = await value.getStringList('storeData');
  //     token = userDetails[5];
  //     print("$token" + "51 line");
  //     var url = Uri.parse(getPlanDetailsCall);
  //     var response = await http.get(url, headers: {'Authorization': token});
  //     decodeDetailsData = json.decode(response.body);
  //     l.e(decodeDetailsData);
  //     var decode = response.body;
  //     l.e(decode);
  //     result = decodeDetailsData['result'];
  //     l.wtf("$result,jjresult");
  //     var status1 = decodeDetailsData['status'];
  //     l.v("$status1,status from profile page");
  //     // if (result != null) {
  //     //   status = true;
  //     //   l.i("SDFSFSFSDF");
  //     // } else {
  //     //   status = false;
  //     //   l.i("EEEE");
  //     // }
  //     setState(() {
  //       subscribedDate =
  //           result[0]['subscribed_date'].toString().substring(0, 10);
  //       l.wtf(subscribedDate);

  //       endingDate = DateTime.parse(
  //           result[0]['ending_date'].toString().substring(0, 10));

  //       l.v(endingDate);
  //       // var bus = DateTime(int.parse(endingDate));

  //       var cu = DateTime.parse(DateTime.now().toString().substring(0, 10));

  //       var k = endingDate.difference(cu).inDays;
  //       l.e("$k,days left in profile page");
  //       // var k = 0;
  //       if (k == 0) {
  //         print("updateapi");
  //         updatePlanApiIsExpiredOrNot();
  //       } else {
  //         numberOfDaysLeft = k;
  //         l.wtf("$numberOfDaysLeft,141 line plan details");
  //         amount = result[0]['amount'];

  //         subscribed_id = result[0]['subscribed_id'];
  //         l.wtf(amount);
  //       }
  //     });
  //   });
  // }

  // updatePlanApiIsExpiredOrNot() async {
  //   var url = Uri.parse(planUpdateApiIsExpiredOrNot);
  //   print(token);
  //   print("$url,156line");
  //   var response = await http.put(url,
  //       body: {"expired": 0.toString()}, headers: {'Authorization': token});
  //   print(response.body);
  //   print("159line profile page");
  // }

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
    // l.e(subscribedDate);
    // getUserName();
    // print(widget.indexnumber);
    print(43);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: profileDetailsData == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(
                            'assets/ProfilePage/mainbackground.png'))),
                height: height,
                width: width,
                child: SingleChildScrollView(
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
                                fit: BoxFit.fill,
                              ),
                            ),
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
                              top: (height - status) * 0.06,
                              left: width * 0.85,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                        'assets/ProfilePage/edit.png'),
                                  ))),
                          Positioned(
                            top: (height - status) * 0.1,
                            left: width * 0.05,
                            child: SingleChildScrollView(
                              child: Container(
                                height: (height - status) * 0.23,
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
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: profileImage == null ||
                                                      profileImage == ""
                                                  ? Container(
                                                      height:
                                                          (height - status) *
                                                              0.08,
                                                      width: width * 0.15,
                                                      color:
                                                          Colors.redAccent[400],
                                                      alignment:
                                                          Alignment.center,
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
                                                      color:
                                                          HexColor('#B91124'),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                board == 2
                                                    // ? Container(
                                                    //     child: isLoading == false
                                                    //         ? TweenAnimationBuilder(
                                                    //             duration: Duration(
                                                    //                 seconds: 3),
                                                    //             tween: Tween(
                                                    //                 begin: 0.0,
                                                    //                 end: 100.0),
                                                    //             builder: (context, _,
                                                    //                 child) {
                                                    //               return Center(
                                                    //                 child: SizedBox(
                                                    //                   height: 40,
                                                    //                   width: 40,
                                                    //                   child: CircularProgressIndicator(
                                                    //                       // color: Colors.teal
                                                    //                       ),
                                                    //                 ),
                                                    //               );
                                                    //             },
                                                    //             onEnd: () {
                                                    //               setState(() {
                                                    //                 isLoading = true;
                                                    //                 print(isLoading);
                                                    //               });
                                                    //             },
                                                    //           )
                                                    ? Container(
                                                        child: Text(
                                                            'Student,CBSE',
                                                            style: TextStyle(
                                                              color: HexColor(
                                                                  '#848484'),
                                                              fontSize: 12,
                                                            )))
                                                    :
                                                    // ? Text('Student,CBSE',
                                                    //     style: TextStyle(
                                                    //       color: HexColor('#848484'),
                                                    //       fontSize: 12,
                                                    //     ))
                                                    Text('Student,StateBoard',
                                                        style: TextStyle(
                                                          color: HexColor(
                                                              '#848484'),
                                                          fontSize: 12,
                                                        )),
                                                enrollmentNumber == "null"
                                                    ? Text('')
                                                    : Text(
                                                        'EnrollmentNumber:$enrollmentNumber',
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '#0AB4A4'),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      Container(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
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
                                                  standard == "null"
                                                      ? Text('')
                                                      : Text(
                                                          'class-$standardClass',
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#05534B'),
                                                              fontSize: 12),
                                                        )
                                                ],
                                              ),
                                              SizedBox(
                                                height: height * 0.005,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/ProfilePage/schoolsvg.svg"),

                                                  // Icon(Icons
                                                  //     .space_dashboard_outlined),

                                                  SizedBox(
                                                    width: width * 0.03,
                                                  ),
                                                  school == "null"
                                                      ? Text("School:",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#05534B'),
                                                              fontSize: 12))
                                                      : Text(
                                                          '$school',
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#05534B'),
                                                              fontSize: 12),
                                                        )
                                                ],
                                              ),
                                              SizedBox(
                                                height: height * 0.005,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/ProfilePage/calendar.svg",
                                                      height: 20,
                                                      width: 20),
                                                  SizedBox(
                                                    width: width * 0.03,
                                                  ),
                                                  academicYear == "null"
                                                      ? Text("Academic Year:",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#05534B'),
                                                              fontSize: 12))
                                                      : Text(
                                                          'Academic Year $academicYear',
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
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ((height - status)) * 0.03,
                      ),
                      Container(
                        height: (height - status) * 0.13,
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
                              SizedBox(height: height * 0.005),
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
                                      height: height * 0.01,
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
                                    ),
                                    SizedBox(height: height * 0.005)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      googleId == null || googleId == ""
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Passwordchange()));
                              },
                              child: Container(
                                height: (height - status) * 0.12,
                                width: width * 0.9,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: HexColor('#FFFFFF'),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#023129'),
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
                                SizedBox(height: height * 0.005),
                                Provider.of<GetPlanDetails>(context,
                                                listen: true)
                                            .amount ==
                                        null
                                    ? Container(
                                        child: isLoading == false
                                            ? TweenAnimationBuilder(
                                                duration: Duration(seconds: 3),
                                                tween: Tween(
                                                    begin: 0.0, end: 100.0),
                                                builder: (context, _, child) {
                                                  return Center(
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      child: CircularProgressIndicator(
                                                          // color: Colors.teal
                                                          ),
                                                    ),
                                                  );
                                                },
                                                onEnd: () {
                                                  setState(() {
                                                    isLoading = true;
                                                    print(isLoading);
                                                  });
                                                },
                                              )
                                            : Container(
                                                width: width * 0.9,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: SvgPicture.asset(
                                                                "assets/ProfilePage/yearlyicon.svg")),
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
                                                              primary:
                                                                  Colors.red,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PaymentDesign()));
                                                          },
                                                          child: Text(
                                                              "Subscribe Now",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ))),
                                                    ),
                                                  ],
                                                ),
                                              ))
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                        "assets/ProfilePage/yearlyicon.svg")),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                                Text(
                                                  "Rs.${Provider.of<GetPlanDetails>(context, listen: true).amount}",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                        "assets/ProfilePage/subscribedDate.svg")),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                                Text(
                                                  // "$subscribedDate",
                                                  "${Provider.of<GetPlanDetails>(context, listen: true).subscribedDate}",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Icon(Icons.alarm),
                                                ),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                                Text(
                                                  "${Provider.of<GetPlanDetails>(context, listen: true).numberOfDaysLeft} left",
                                                  style:
                                                      TextStyle(fontSize: 12),
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
      ),
    );
  }
}
