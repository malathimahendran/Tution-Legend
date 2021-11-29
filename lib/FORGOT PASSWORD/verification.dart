import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'changepassword.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var otp = TextEditingController();
  Future verifyOtp(e, o) async {
    String url = 'http://71026514a79e.ngrok.io/parampara/compare_otp';
    final response =
        await http.post(Uri.parse(url), body: {'email': e, 'tempotp': o});
    print(response);
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Changepassword()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print(height);
    var width = MediaQuery.of(context).size.width;
    print(width);

    var bottom = kBottomNavigationBarHeight;
    print(bottom);
    var status = MediaQuery.of(context).padding.top;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        // reverse: true,
        child: Container(
          // margin: EdgeInsets.only(top: 20),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Verification',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'RobotoMono',
                    color: Colors.black),
              ),
              Image.asset('assets/FORGOTPASSWORD/forgotpassword.png',
                  width: (width - 90) - 20),
              Text(
                '  Enter the Verification code we \n     just sent you on your email \n                    address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  fontFamily: 'RobotoMono',
                  color: Colors.black,
                ),
              ),
              Container(
                width: (width - 10) - 20,
                // height: height * 0.3,
                child: OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 55,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you didn't receive a code!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'RobotoMono',
                      color: Colors.black38,
                    ),
                  ),
                  Text(
                    "Resend",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'RobotoMono',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Container(
                width: (width * 0.5) - 20,
                height: (height * 0.09) - 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Changepassword()));
                  },
                  child: Text(
                    'Verify',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
