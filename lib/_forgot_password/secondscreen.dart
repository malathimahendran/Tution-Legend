import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutionmaster/_forgot_password/thirdscreen.dart';
// import 'package:tutionmaster/FORGOT%20PASSWORD/changepassword.dart';

class Passwordsecondscreen extends StatefulWidget {
  Passwordsecondscreen({this.email});
  final email;

  @override
  _PasswordsecondscreenState createState() => _PasswordsecondscreenState();
}

class _PasswordsecondscreenState extends State<Passwordsecondscreen> {
  var otp, status;
  verifyOtp() async {
    var email = widget.email;
    // SharedPreferences otp = await SharedPreferences.getInstance();
    // var useOTP = otp.getString('StoreOTP');
    // print("$useOTP,22 line");
    print("$otp,jjjjjjjjjjjj");
    String url = 'http://www.cviacserver.tk/tuitionlegend/register/compare_otp';
    final response = await http
        .post(Uri.parse(url), body: {'email': email, 'otp': otp.toString()});
    print(response);
    print(response.body);
    var decodeDetails = json.decode(response.body);
    status = decodeDetails['status'];
    if (status == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Changepassword(
                    email: widget.email,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print(height);
    var width = MediaQuery.of(context).size.width;
    print(width);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/LoginPage/logintop.png'),
                          fit: BoxFit.fill)),
                ),
                Container(
                  width: width * 0.73,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 97),
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'RobotoMono',
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Image.asset(
                        'assets/FORGOTPASSWORD/forgotpassword.png',
                        width: width * 0.6,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Please enter your verification code    ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'RobotoMono',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'We will send a verification code to your registered email ID',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          fontFamily: 'RobotoMono',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: (width * 0.8),
                        // height: height * 0.3,
                        child: OTPTextField(
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: width * 0.15,
                          fieldStyle: FieldStyle.box,
                          style: TextStyle(fontSize: 10),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) async {
                            print("Completed: " + pin);
                            otp = pin;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Container(
                  width: width * 0.8,
                  height: height * 0.05,
                  child: ElevatedButton(
                      onPressed: () {
                        verifyOtp();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Changepassword()));
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor('#243665')),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
