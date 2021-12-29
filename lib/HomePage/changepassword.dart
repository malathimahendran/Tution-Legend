import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

class Passwordchange extends StatefulWidget {
  Passwordchange({Key? key}) : super(key: key);

  @override
  _PasswordchangeState createState() => _PasswordchangeState();
}

class _PasswordchangeState extends State<Passwordchange> {
  bool secureText = true;
  bool secureText1 = true;
  bool secureText2 = true;

  var currentPassword = TextEditingController();
  var newPassword = TextEditingController();
  var email, token;

  final l = Logger();

  fun() async {
    String url = 'http://www.cviacserver.tk/tuitionlegend/home/change_password';
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      // setState(() {
      email = userDetails[1];
      token = userDetails[5];
      l.e(email);
      final response = await http.post(Uri.parse(url), body: {
        'email': email.toString(),
        'currentPassword': currentPassword.text.toString(),
        'newPassword': newPassword.text.toString()
      }, headers: {
        'Authorization': token,
      });
      l.w(currentPassword.text.toString());
      l.i(newPassword.text.toString());
      print(response);
      print(response.body);
      var otpdecode = json.decode(response.body);
      l.w(otpdecode);
      var status = otpdecode['status'];
      if (status == true) {
        final snackBar = SnackBar(
          backgroundColor: Colors.teal.shade600,
          content: Text('Password Updated Successfully'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'Please check your password & Please use registered mail id'),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/LoginPage/logintop.png'),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                        child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.1,
                          height: height * 0.1,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: width * 0.12),
                        Text(
                          'Create New Password',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    )),
                  ],
                ),
                Container(
                  height: height * 0.7,
                  width: width * 0.85,
                  child: Column(
                    children: [
                      TextField(
                        controller: currentPassword,
                        obscuretext: secureText,
                        hintText: 'Current Password',
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
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      TextField(
                        controller: newPassword,
                        obscuretext: secureText1,
                        hintText: 'New Password',
                        suffixIcon: IconButton(
                          color: HexColor('#3F3F3F'),
                          icon: secureText1
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              secureText1 = !secureText1;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      TextField(
                        obscuretext: secureText2,
                        hintText: 'Confirm New Password',
                        suffixIcon: IconButton(
                          color: HexColor('#3F3F3F'),
                          icon: secureText2
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              secureText2 = !secureText2;
                            });
                          },
                        ),
                        validator: (val) {
                          call(String values) {
                            if (values.isEmpty) {
                              return "Confirm Password is required";
                            } else if (values != newPassword.text) {
                              return "Password does not match";
                            } else {
                              return null;
                            }
                          }

                          return call(val);
                        },
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Container(
                        width: width * 0.8,
                        height: height * 0.05,
                        child: ElevatedButton(
                            onPressed: () {
                              fun();
                              // sendOtp();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Passwordsecondscreen()));
                            },
                            child: Text(
                              'Change Password',
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor('#243665')),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )))),
                      ),
                    ],
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

class TextField extends StatelessWidget {
  TextField(
      {this.hintText,
      this.obscuretext,
      this.controller,
      this.validator,
      this.suffixIcon});
  final hintText, obscuretext, controller, validator, suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // textCapitalization: textCapitalization,
        validator: validator,
        obscureText: obscuretext,
        controller: controller,
        cursorColor: HexColor('#707070'),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('#707070')),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
                textStyle:
                    TextStyle(color: HexColor('#707070'), fontSize: 14))));
  }
}
