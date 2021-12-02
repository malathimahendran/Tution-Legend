import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:http/http.dart' as http;

class Changepassword extends StatefulWidget {
  Changepassword({this.email});
  final email;

  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool secureText1 = true;
  bool secureText = true;
  var newpassword = TextEditingController();
  var conformpassword = TextEditingController();
  changePass() async {
    String url =
        'http://www.cviacserver.tk/tuitionlegend/register/update_password';
    final response = await http.post(Uri.parse(url), body: {
      "email": widget.email,
      "password": newpassword.text.toString(),
    });
    print(response.body);
    var decodeDetails = json.decode(response.body);
    print(decodeDetails);
    var status = decodeDetails['status'];
    if (status == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  // var passwordValidator = MultiValidator([
  //   RequiredValidator(errorText: 'password is required'),
  //   MinLengthValidator(6, errorText: 'password must be at least 8 digits long'),
  //   PatternValidator(r'(?=.*?[#?!@$%^&*-])',
  //       errorText: 'passwords must have at least one special character')
  // ]);
  call(String values) {
    if (values.isEmpty) {
      return "Confirm Password is required";
    } else if (values != newpassword.text) {
      return "Password does not match";
    } else {
      return null;
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
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
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
                  width: width * 0.7,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create new Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your new password must be different from previous used passwords",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: width * 0.7,
                      height: height * 0.06,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: passwordValidator,
                        controller: newpassword,
                        obscureText: secureText1,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.black,
                            icon: secureText1
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                secureText1 = !secureText1;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: width * 0.7,
                      height: height * 0.06,
                      child: TextFormField(
                        controller: conformpassword,
                        obscureText: secureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return call(val!);
                        },
                        decoration: InputDecoration(
                          // labelText: "Confirm Password",
                          // labelStyle: GoogleFonts.poppins(
                          //   textStyle: TextStyle(fontSize: 15, color: Colors.black),
                          // ),
                          suffixIcon: IconButton(
                            color: Colors.black,
                            icon: secureText
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                secureText = !secureText;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 50),
                Container(
                  width: width * 0.7,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: HexColor("#243665"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        changePass();
                      },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
