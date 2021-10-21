import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';
import 'package:tutionmaster/StartingLearningPage/startlearning.dart';
import 'package:logger/logger.dart';

class Register extends StatefulWidget {
  // const Register({Key? key, String? deviceId}) : super(key: key);
  Register({this.deviceId, this.googleuser, this.deviceid});
  final deviceId;
  final googleuser;
  final deviceid;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final l = Logger();
  var googleDetails;
  bool secureText = true;
  bool secureText1 = true;
  List<Map<String, dynamic>> items = [
    {
      'value': "9",
      'label': '9',
    },
    {
      'value': "10",
      'label': '10',
    },
    {
      'value': "11",
      'label': '11',
    },
    {
      'value': "12",
      'label': '12',
    },
  ];
  String? selectedValue = '9th Standard';
  var username = TextEditingController();
  var mobileno = TextEditingController();
  var email = TextEditingController();
  var deviceid = TextEditingController();
  var boardofeducation = TextEditingController();
  var standard = TextEditingController();
  var password = TextEditingController();
  var fcm = TextEditingController();
  var confirmpassword = TextEditingController();
  var referralcode = TextEditingController();

  get read => null;
  @override
  void initState() {
    super.initState();
    getGoogleData();
  }

  registerApi() async {
    print(widget.deviceId);
    var url =
        Uri.parse('http://www.cviacserver.tk/tuitionlegend/register/sign_up');
    var response = await http.post(url, body: {
      'user_name': username.text.toString(),
      'email': email.text.toString(),
      'phone': mobileno.text.toString(),
      'password': password.text.toString(),
      'device_id': widget.deviceid.toString(),
      'fcm': "",
      'reference_code': referralcode.text.toString(),
      'class': standard.text.toString(),
      'google_id': widget.googleuser.id.toString()
    }).then((value) async {
      var decodeDetails = json.decode(value.body);
      print(decodeDetails);
      print(widget.deviceId);
      var userToken = decodeDetails['result'];
      var googleId = decodeDetails['user']['google_id'];
      var userName = decodeDetails['user']['user_name'];
      print("$userName" + "line87");
      var email = decodeDetails['user']['email'];
      var phone = decodeDetails['user']['phone'];
      var standard = decodeDetails['user']['class'];
      List<String> details = [userName, email, phone, standard, userToken];
      print(details);
      Shared().shared().then((value) async {
        var storeData = await value.setStringList('storeData', details);
        print("$storeData" + "line100");
      });
      print('$googleId ,line 86');

      // var statusCode = decodeDetails['statusCode'];
      if (value.statusCode == 200) {
        final snackBar = SnackBar(
          backgroundColor: HexColor('#27AE60'),
          content: Text('Registration Successfully'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        if (googleId == "" && googleId == null) {
          print('$googleId ,line 102');
          print('inside if');
          Navigator.popAndPushNamed(context, 'loginpage');
        } else {
          print('$googleId ,line 107');
          print('inside else');
          Navigator.popAndPushNamed(context, 'homescreen');
        }
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Duplicate Entry'),
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  getGoogleData() {
    setState(() {
      if (widget.googleuser == null) {
        username.text = ''.toString();
        email.text = ''.toString();
      } else {
        username.text = widget.googleuser.displayName;
        email.text = widget.googleuser.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // googleDetails = widget.googleuser;
    // String googleUserName = googleDetails.displayName;
    // var googleMail = googleDetails.email;
    // print(googleUserName);
    // print(googleMail);
    // print("$googleDetails" + "61");
    // print(widget.deviceId);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(
          top: status,
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/RegisterPage/registerbackground.png'),
                fit: BoxFit.fill)),
        // backgroundColor: Color(0xF2F9F9F9),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: ((height - status) * 0.2) * 0.2),
                height: (height - status) * 0.15,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: width * 0.25,
                            child: InkWell(
                              onTap: () {
                                Navigator.popAndPushNamed(context, 'loginpage');
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 30,
                                color: HexColor('#545454'),
                              ),
                            )),
                        Container(
                          width: width * 0.75,
                          child: Text("Let's Get Started",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                // fontFamily: 'Pacifico',
                              ))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ((height - status)) * 0.01,
                    ),
                    Text('Create Your Account',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          // fontFamily: 'Pacifico',
                        )))
                  ],
                ),
              ),
              Container(
                height: height,
                width: width,
                child: Column(
                  children: [
                    Textfield(
                      hintText: 'UserName',
                      controller: username,
                      icon: Icon(Icons.person, color: HexColor('#3F3F3F')),
                    ),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Textfield(
                        type: TextInputType.number,
                        hintText: 'MobileNo',
                        controller: mobileno,
                        icon: Icon(Icons.phone_iphone,
                            color: HexColor('#3F3F3F'))),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Textfield(
                        read: widget.googleuser != null ? true : false,
                        type: TextInputType.emailAddress,
                        hintText: 'Email',
                        controller: email,
                        icon: Icon(Icons.email, color: HexColor('#3F3F3F'))),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Textfield(
                        read: true,
                        hintText: 'CBSE',
                        controller: boardofeducation,
                        icon: Icon(Icons.cast_for_education,
                            color: HexColor('#3F3F3F'))),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      child: SelectFormField(
                        controller: standard,
                        changeIcon: true,
                        dialogTitle: 'Pick a item',
                        dialogCancelBtn: 'CANCEL',
                        enableSearch: true,
                        // dialogSearchHint: 'Standard',
                        items: items,
                        decoration: InputDecoration(
                            hintText: 'Standard',
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 12)),
                            filled: true,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            fillColor: Colors.white,
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 1),
                            ),
                            // contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color(0xF2FFFFFF), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Color(0xF227DEBF)),
                            ),
                            prefixIcon:
                                Icon(Icons.school, color: HexColor('#3F3F3F'))),
                      ),
                    ),
                    Visibility(
                        visible: widget.googleuser == null ? true : false,
                        child: Column(
                          children: [
                            SizedBox(
                              height: ((height - status)) * 0.03,
                            ),
                            Textfield(
                              suffixicon: IconButton(
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
                              obscuretext: secureText1,
                              hintText: 'Password',
                              controller: password,
                              icon:
                                  Icon(Icons.lock, color: HexColor('#3F3F3F')),
                            ),
                            SizedBox(
                              height: ((height - status)) * 0.03,
                            ),
                            Textfield(
                                suffixicon: IconButton(
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
                                validator: (val) {
                                  call(String values) {
                                    if (values.isEmpty) {
                                      return "Confirm Password is required";
                                    } else if (values != password.text) {
                                      return "Password does not match";
                                    } else {
                                      return null;
                                    }
                                  }

                                  return call(val);
                                },
                                obscuretext: secureText,
                                hintText: 'Confirm Password',
                                controller: confirmpassword,
                                icon: Icon(Icons.lock,
                                    color: HexColor('#3F3F3F'))),
                          ],
                        )),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Textfield(
                        type: TextInputType.number,
                        hintText: 'Referral Code',
                        controller: referralcode,
                        icon: Icon(
                          Icons.qr_code,
                          color: HexColor('#3F3F3F'),
                        )),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Container(
                      width: width * 0.8,
                      height: height * 0.05,
                      child: ElevatedButton(
                          onPressed: () {
                            registerApi();
                          },
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )))),
                    ),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.poppins(),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.popAndPushNamed(context, 'loginpage');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginPage()));
                          },
                          child: Text('SignIn',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    color: HexColor('#514880')),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ((height - status)) * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  final hintText,
      icon,
      controller,
      read,
      type,
      obscuretext,
      suffixicon,
      validator;

  Textfield({
    this.hintText,
    this.icon,
    this.suffixicon,
    this.obscuretext = false,
    this.controller,
    this.validator,
    this.read = false,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return Container(
      width: width * 0.8,
      height: height * 0.073,
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscuretext,
        keyboardType: type,
        readOnly: read,

        // expands: true,
        // minLines: null,

        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 12)),
            filled: true,
            fillColor: HexColor('#FFFFFF'),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Color(0xF2FFFFFF), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Color(0xF227DEBF), width: 1),
            ),
            prefixIcon: icon,
            suffixIcon: suffixicon),
      ),
    );
  }
}
