import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/FORGOT%20PASSWORD/verification.dart';

class Forgotpassword extends StatefulWidget {
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  Future sendOtp(e) async {
    String url = 'https://www.cviacserver.tk/parampara/parampara/forgot_pass';
    final response = await http.post(Uri.parse(url), body: {
      'email': e,
    });

    print(response);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    print(height);
    var width = MediaQuery.of(context).size.width;
    print(width);

    var bottom = kBottomNavigationBarHeight;
    print(bottom);
    var status = MediaQuery.of(context).padding.top;
    print(status);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.white,
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'RobotoMono',
                      color: Colors.black),
                ),
                Image.asset(
                  'assets/FORGOTPASSWORD/verification.jpg',
                  width: (width - 90),
                ),
                Text(
                  '     Enter the email address \nassociated with your account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'RobotoMono',
                    color: Colors.black,
                  ),
                ),
                Text(
                  'We will email you a link to reset \n              your password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'RobotoMono',
                    color: Colors.black38,
                  ),
                ),
                Container(
                  width: (width - 50) - 20,
                  child: TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    // autofocus: true,
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      // labelText: ' Enter Email Address',
                      hintText: '                Enter Email Address',
                    ),
                    style: TextStyle(
                        fontSize: 18.0, height: 1.5, color: Colors.black38),
                  ),
                ),
                Container(
                  width: (width * 0.5) - 20,
                  height: (height * 0.09) - 20,
                  child: ElevatedButton(
                    onPressed: () {
                      final String e = email.text;
                      sendOtp(e);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Verification()));
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'RobotoMono',
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: HexColor('#0A4E51'),
                      side: BorderSide(width: 1, color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
