import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/FCM%20Token/fcm_token.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Login/argumentpass.dart';
import 'package:tutionmaster/Register/register.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/StartingLearningPage/startlearning.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final l = Logger();
  var hintText,
      icon,
      user,
      storeGoogleUserData,
      userDetails,
      userName,
      storeemail,
      phone,
      standard,
      token;
  var controller;
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  var googleDisplayName, googleDisplayEmail, googleId, photourl, profileImage;
  var fcm_token;
  String? deviceId, finalDeviceId;
  GoogleSignInAccount? googleUser;

  signInWithGoogle() async {
    googleUser = await GoogleSignIn().signIn();
    print(googleUser?.displayName);
    print(googleUser?.email);

    googleDisplayName = googleUser!.displayName;
    googleDisplayEmail = googleUser!.email;
    googleId = googleUser!.id;
    photourl = googleUser!.photoUrl;
    // List<String> details = [
    //   googleDisplayName,
    //   googleDisplayEmail,
    //   googleId,
    // ];
    // Shared().shared().then((value) async {
    //   storeGoogleUserData =
    //       await value.setStringList('storeGoogleUser', details);
    // });

    print('30');
    await apiGoogle();
    print(deviceId);
    print(43);
  }

  void initState() {
    super.initState();
    initPlatformState();
    getToken();
  }

  getToken() async {
    fcm_token = await FcmToken.gettingToken();
    print(fcm_token);
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    if (!mounted) return;

    finalDeviceId = deviceId;
    print("deviceId->$finalDeviceId");
  }

  loginApi() async {
    var decodeDetails;
    var url =
        Uri.parse('http://www.cviacserver.tk/tuitionlegend/register/sign_in');
    var response = await http.post(url, body: {
      'email': email.text.toString(),
      'password': password.text.toString(),
      'device_id': finalDeviceId.toString(),
    }).then((value) async {
      var decodeDetails = json.decode(value.body);
      print(decodeDetails);
      print(66);
      print(value.statusCode);
      var statuscode = value.statusCode;
      print(statuscode);
      user = decodeDetails['user'];
      print(user);
      // print(decodeDetails['user'][0]['user_name']);
      String token = decodeDetails['token'].toString();
      String userName = decodeDetails['user'][0]['user_name'].toString();
      print('$userName,line 118 login page');
      print('$token,line 119 login page');
      String storeemail = decodeDetails['user'][0]['email'].toString();
      String phone = decodeDetails['user'][0]['phone'].toString();
      String standard = decodeDetails['user'][0]['class'].toString();

      l.w(userName);
      l.w(storeemail);

      print('$standard,line 119 login page');
      l.w(phone);
      l.w(standard);
      l.w(token);
      storingAllDetails(
        userName: userName,
        storeemail: storeemail,
        phone: phone,
        standard: standard,
        token: token,
        // googleId:googleId,
      );
      // List<String> details = [
      //   userName,
      //   email,
      //   phone,
      //   standard,
      //   profileImage,
      //   token
      // ];
      // Shared().shared().then((value) async {
      //   var storeData = await value.setStringList('storeData', details);
      //   print(storeData);
      // });

      print(user);
      print(71);

      if (statuscode == 200) {
        final snackBar = SnackBar(
          backgroundColor: HexColor('#27AE60'),
          content: Text('Login Successfully'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.popAndPushNamed(context, AllRouteNames.startlearning);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => StartLearning()));
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Invalid Email or Password '),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  apiGoogle() async {
    print(googleId);
    print(googleDisplayEmail);
    print(deviceId);
    print(photourl);
    print(140);
    var url = Uri.parse(
        'http://www.cviacserver.tk/tuitionlegend/register/google_login');
    var response = await http.post(url, body: {
      'device_id': deviceId,
      // 'device_id': 34.toString(),
      'email': googleDisplayEmail,
      'google_id': googleId,
    });
    var decodeDetail = json.decode(response.body);
    print(decodeDetail);
    userDetails = decodeDetail['user_details'];
    print("$userDetails" + "161line");

    var statusCode = response.statusCode;
    var status = decodeDetail['status'];

    if (status == false) {
      Navigator.popAndPushNamed(context, AllRouteNames.registerpage,
          arguments:
              ArgumentPass(deviceId: finalDeviceId, googleUser: googleUser));
    } else {
      final snackBar = SnackBar(
        backgroundColor: HexColor('#27AE60'),
        content: Text('Register Successfully'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.popAndPushNamed(context, AllRouteNames.startlearning);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    var userName = userDetails[0]['user_name'].toString();
    var storeemail = userDetails[0]['email'].toString();
    var phone = userDetails[0]['phone'].toString();
    var standard = userDetails[0]['class'].toString();
    var profileImage = userDetails[0]['profile_image'].toString();
    l.i(userDetails[0]['profile_image'].toString());
    var token = decodeDetail['token'].toString();

    storingAllDetails(
      userName: userName,
      storeemail: storeemail,
      phone: phone,
      standard: standard,
      profileImage: profileImage,
      token: token,
      googleId: googleId,
    );

    // List<String> details = [
    //   userName,
    //   storeemail,
    //   phone,
    //   standard,
    //   profileImage,
    //   token
    // ];
    // Shared().shared().then((value) async {
    //   var storeData = await value.setStringList('storeData', details);
    //   print(storeData);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    final keyss = MediaQuery.of(context).viewInsets.bottom != 0;
    // var height1=height-status;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     height: (height - status) * 0.30,
      //     width: width,
      //     decoration: BoxDecoration(
      //         // color: Colors.pink,
      //         image: DecorationImage(
      //             image: AssetImage("assets/LoginPage/logintop.png"),
      //             fit: BoxFit.fill)),
      //   ),
      // ),
      body: Container(
        height: height,
        // padding: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          // color: Colors.pink,
          image: DecorationImage(
              image: AssetImage("assets/ProfilePage/mainbackground.png"),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Container(
              height: (height - status) * 0.30,
              width: width,
              decoration: BoxDecoration(
                  // color: Colors.pink,
                  image: DecorationImage(
                      image: AssetImage("assets/LoginPage/logintop.png"),
                      fit: BoxFit.fill)),
            ),
            Positioned(
              top: 150,
              child: Column(
                children: [
                  Container(
                      height: (height - status) * 0.70,
                      width: width,
                      // color: Colors.black,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/LoginPage/logincenter.png",
                            height: height * 0.2,
                            width: width * 1,
                          ),
                          SizedBox(height: 4),
                          Text("Welcome",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          SizedBox(height: 4),
                          Text(
                            "Login to your existing Account",
                            style: GoogleFonts.poppins(),
                          ),
                          SizedBox(height: 7),
                          customContainerTextField(
                            height,
                            width,
                            hintText = "UserName or Email",
                            icon = Icon(Icons.person),
                            controller = email,
                          ),
                          SizedBox(height: 7),
                          customContainerTextField(
                            height,
                            width,
                            hintText = "Password",
                            icon = Icon(Icons.lock),
                            controller = password,
                            obscureText: true,
                          ),
                          // SizedBox(height: 5),
                          Container(
                            width: width * 0.8,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: CheckboxListTile(
                                          activeColor: HexColor('#FF465C'),
                                          checkColor: Colors.white,
                                          contentPadding: EdgeInsets.zero,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          title: Text('Remember me  ',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )),
                                          value: isChecked,
                                          onChanged: (value) => setState(() {
                                                isChecked = value!;
                                                // signInButtonEnable = !signInButtonEnable;
                                              })),
                                    ),
                                  ),
                                ),
                                Text("Forgot Password?",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(fontSize: 12)))
                              ],
                            ),
                          ),
                          // SizedBox(height: 5),
                          Container(
                            width: width * 0.8,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor("#FF465C"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  loginApi();
                                },
                                child: Text("Log In",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(color: Colors.white),
                                    ))),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "OR",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 12)),
                          ),
                          SizedBox(height: 2),
                          Container(
                            width: width * 0.4,
                            child: ElevatedButton(
                                onPressed: () {
                                  signInWithGoogle();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/LoginPage/google.jpeg',
                                        height: 20,
                                        width: 30,
                                      ),
                                    ),
                                    Container(
                                        // color: HexColor('#0077FF'),
                                        // height: height * 0.04,
                                        width: width * 0.2,
                                        child: Text("Login",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black),
                                            ))),
                                  ],
                                )),
                          ),
                          SizedBox(height: 3),
                          Container(
                            width: width * 0.6,
                            child: Row(children: [
                              Text("Don't have an account?"),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AllRouteNames.registerpage,
                                      arguments: ArgumentPass(
                                        deviceId: finalDeviceId,
                                        googleUser: null,
                                      ));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 15,
                                          color: HexColor('#514880'))),
                                ),
                              )
                            ]),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  storingAllDetails(
      {userName,
      storeemail,
      phone,
      standard,
      profileImage,
      token,
      googleId}) async {
    List<String> storing = [
      userName,
      storeemail,
      phone,
      standard,
      profileImage ?? "",
      token,
      googleId ?? ""
    ];

    print(storing);
    print(320);
    Shared()
        .shared()
        .then((value) => value.setStringList('storeData', storing));
  }

  Container customContainerTextField(
      double height, double width, hintText, icon, controller,
      {obscureText = false}) {
    return Container(
      height: height * 0.05,
      width: width * 0.8,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 12)),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: HexColor('#27DEBF'))),
        ),
      ),
    );
  }
}
