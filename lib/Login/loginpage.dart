import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/FCM%20Token/fcm_token.dart';
// import 'package:tutionmaster/FORGOT%20PASSWORD/forgotpasswpord.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Login/argumentpass.dart';
import 'package:tutionmaster/ProfilePage/logout.dart';

import 'package:tutionmaster/Register/register.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/StartingLearningPage/startlearning.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tutionmaster/_forgot_password/firstscreen.dart';

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
  bool secureText = true;
  var controller;
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // Function fun = signInWithGoogle(){};
  Function fu = (a) {};
  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  var googleDisplayName, googleDisplayEmail, googleId, photourl, profileImage;
  var fcm_token;
  String? deviceId, finalDeviceId;
  GoogleSignInAccount? googleUser;
  bool isPressed = false;
  var _formKey = GlobalKey<FormState>();
  void handleRemeberme(bool value) {
    print("Handle Rember Me");
    isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', email.text);
        prefs.setString('password', password.text);
        l.i(email.text);
      },
    );
    setState(() {
      isChecked = value;
    });
  }

  void loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          isChecked = true;
        });
        email.text = _email;
        password.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }

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
    loadUserEmailPassword();
    print("deviceID:$finalDeviceId");
  }

  getToken() async {
    fcm_token = await FcmToken.gettingToken();
    print('line 83333333333333333333$fcm_token');
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
    l.e('helo');
    var url = Uri.parse(loginApiCall);
    var response = await http.post(url, body: {
      'email': email.text.toString(),
      'password': password.text.toString(),
      'device_id': finalDeviceId.toString(),
      // 'fcm': fcm_token.toString()
    }).then((value) async {
      var decodeDetails = json.decode(value.body);
      print("$finalDeviceId,deviceID");
      var statuscode = value.statusCode;

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
      // print(decodeDetails['user'][0]['user_name']);
      String token = decodeDetails['token'].toString();
      String userName = decodeDetails['user'][0]['user_name'].toString();
      print('$userName,line 118 login page');
      print('$token,line 119 login page');
      String storeemail = decodeDetails['user'][0]['email'].toString();
      String phone = decodeDetails['user'][0]['phone'].toString();
      String standard = decodeDetails['user'][0]['class'].toString();
      String school = decodeDetails['user'][0]['school'].toString();
      String enrollmentNumber =
          decodeDetails['user'][0]['enrollment_number'].toString();
      String academicYear =
          decodeDetails['user'][0]['academic_year'].toString();

      l.wtf(
          "$token,$userName,$storeemail,$phone,$standard,$school,$enrollmentNumber,$academicYear,");

      l.wtf('$token');

      storingAllDetails(
        userName: userName,
        storeemail: storeemail,
        phone: phone,
        standard: standard,
        token: token,
        school: school,
        academicYear: academicYear,
        enrollmentNumber: enrollmentNumber,
      );
    });
  }

  apiGoogle() async {
    print(googleId);
    print(googleDisplayEmail);
    print(deviceId);
    print(photourl);
    print(140);
    var url = Uri.parse(apiGoogleCall);
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
    print(
        '$statusCode,$status,$decodeDetail,"line192 Login Page google login"');
    print(fcm_token);
    if (status == false) {
      Navigator.popAndPushNamed(context, AllRouteNames.registerpage,
          arguments:
              ArgumentPass(deviceId: finalDeviceId, googleUser: googleUser));
    } else if (statusCode == 401) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('Please use same device you registered when yor are login'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      LogOutForAll.outTemporary(context);
    } else {
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
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    var userName = userDetails[0]['user_name'].toString();
    var storeemail = userDetails[0]['email'].toString();
    var phone = userDetails[0]['phone'].toString();
    var standard = userDetails[0]['class'].toString();
    var profileImage = userDetails[0]['profile_image'].toString();
    var school = userDetails[0]['school'].toString();
    var enrollmentNumber = userDetails[0]['enrollment_number'].toString();
    var academicYear = userDetails[0]['academic_year'].toString();
    l.i(userDetails[0]['profile_image'].toString());
    var token = decodeDetail['token'].toString();
    print(
        "$userName,$storeemail,$phone,$standard,$profileImage,$school,$enrollmentNumber,$academicYear,Line 222 Login page");

    print(token);

    storingAllDetails(
      userName: userName,
      storeemail: storeemail,
      phone: phone,
      standard: standard,
      profileImage: profileImage,
      token: token,
      googleId: googleId,
      school: school,
      academicYear: academicYear,
      enrollmentNumber: enrollmentNumber,
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
    var height1 = MediaQuery.of(context).size.height * 0.01;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var font = 2;
    final keyss = MediaQuery.of(context).viewInsets.bottom != 0;
    // var height1=height-status;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double subTextWelcome = 1.8;
    double subTextExistAccount = 1.7;
    double subTextSmall = 1.4;
    double subTextSignup = 1.5;
    double subTextLogin = 1.6;
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
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
        body: Form(
          // autovalidate: true, //check for validation while typing
          key: formKey,
          child: Container(
            height: height,
            // padding: EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              // color: Colors.pink,
              image: DecorationImage(
                  image:
                      AssetImage("assets/RegisterPage/registerbackground.png"),
                  fit: BoxFit.fill),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: (height - status) * 0.20,
                    width: width,
                    decoration: BoxDecoration(
                        // color: Colors.pink,
                        image: DecorationImage(
                            image: AssetImage("assets/LoginPage/logintop.png"),
                            fit: BoxFit.fill)),
                  ),
                  Column(
                    children: [
                      Container(
                          height: (height - status) * 0.80,
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          unitHeightValue * subTextWelcome)),
                              SizedBox(height: 4),
                              Text(
                                "Login to your existing Account",
                                style: TextStyle(
                                    fontSize:
                                        unitHeightValue * subTextExistAccount),
                              ),
                              SizedBox(height: 20),
                              customContainerTextField(
                                height,
                                width,
                                unitHeightValue,
                                subTextSmall,
                                hintText = "UserName or Email",
                                icon = Icon(Icons.person),
                                controller = email,
                                validator1: (value) {
                                  if (value.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return 'Enter a valid email!';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 7),
                              customContainerTextField(
                                height,
                                width,
                                unitHeightValue,
                                subTextSmall,
                                hintText = "Password",
                                icon = Icon(Icons.lock),
                                controller = password,
                                obscureText: secureText,
                                suffixIcon: IconButton(
                                  color: HexColor('#3F3F3F'),
                                  icon: secureText
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      secureText = !secureText;
                                    });
                                  },
                                ),
                                validator1: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter a valid password!';
                                  }
                                  return null;
                                },
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
                                                  ListTileControlAffinity
                                                      .leading,
                                              title: Text('Remember me  ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          unitHeightValue *
                                                              subTextSmall)),
                                              value: isChecked,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    isChecked = value!;
                                                    handleRemeberme(value);

                                                    // signInButtonEnable = !signInButtonEnable;
                                                  })),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Passwordscreen1()));
                                      },
                                      child: Text("Forgot Password?",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: unitHeightValue *
                                                      subTextSmall))),
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(height: 5),
                              Container(
                                width: width * 0.8,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor("#243665"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        loginApi();
                                      }

                                      // if (formkey.currentState!.validate()) {
                                      //   Text("ERERere");
                                      //   print("Validated");
                                      // } else {
                                      //   print("Not Validated");
                                      // }
                                    },
                                    child: Text("Log In",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: unitHeightValue *
                                                  subTextLogin),
                                        ))),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "OR",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize:
                                            unitHeightValue * subTextLogin)),
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
                                                      color: Colors.black,
                                                      fontSize:
                                                          unitHeightValue *
                                                              subTextLogin),
                                                ))),
                                      ],
                                    )),
                              ),
                              SizedBox(height: 3),
                              Container(
                                width: width * 0.6,
                                child: Row(children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontSize:
                                            unitHeightValue * subTextSmall),
                                  ),
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
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: unitHeightValue *
                                                  subTextSignup,
                                              color: HexColor('#514880'))),
                                    ),
                                  )
                                ]),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  customContainerTextField(double height, double width, double unitHeightValue,
      double subTextSmall, hintText, icon, controller,
      {obscureText = false, suffixIcon, validator1}) {
    return Container(
      height: height * 0.075,
      width: width * 0.8,
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(height * 0.004),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: unitHeightValue * subTextSmall)),
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

  // valid({val}) {
  //   if (val == 'email') {}
  // }
}
