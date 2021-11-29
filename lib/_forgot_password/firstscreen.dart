import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/_forgot_password/secondscreen.dart';
import 'package:http/http.dart' as http;

class Passwordscreen1 extends StatefulWidget {
  Passwordscreen1({Key? key}) : super(key: key);

  @override
  _Passwordscreen1State createState() => _Passwordscreen1State();
}

class _Passwordscreen1State extends State<Passwordscreen1> {
  var email = TextEditingController();
  final l = Logger();
  sendOtp() async {
    String url =
        'http://www.cviacserver.tk/tuitionlegend/register/send_otp?filter=email&data=${email.text}';

    final response = await http.get(Uri.parse(url));
    print(response);
    print(response.body);
    var otpdecode = json.decode(response.body);
    l.w(otpdecode);
    var status = otpdecode['status'];
    if (status == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Passwordsecondscreen(
                    email: email.text,
                  )));
    } else {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please use registered mail Id'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                          image: AssetImage('assets/LoginPage/logintop.png'))),
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
                        'assets/FORGOTPASSWORD/verification.jpg',
                        width: width * 0.6,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Please enter your registered email ID',
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
                        width: width * 0.75,
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,

                          // autofocus: true,
                          // textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black38,
                            ),
                            // labelText: ' Enter Email Address',
                            hintText: 'example@gmail.com',
                          ),
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
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
                        sendOtp();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Passwordsecondscreen()));
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
