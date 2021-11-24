import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/ALL%20API%20FOLDER/all_api.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

import 'custom_text.dart';
import 'custom_text_form_field.dart';
import 'provider_for_edit_page.dart';
import 'package:http/http.dart' as http;

class CustomExpandedWithTextAndFormField extends StatefulWidget {
  CustomExpandedWithTextAndFormField(
      {Key? key,
      required this.height,
      required this.status,
      required this.width,
      required this.userName,
      required this.enrollmentNumber,
      required this.grade,
      required this.schoolName,
      required this.academicYear,
      required this.contactNumber,
      required this.email,
      required this.password,
      required this.heightFocus,
      required this.keyboardType})
      : super(key: key);

  final double height;
  final double status;
  final double width;
  final TextEditingController userName;
  final TextEditingController enrollmentNumber;
  final TextEditingController grade;
  final TextEditingController schoolName;
  final TextEditingController academicYear;
  final TextEditingController contactNumber;
  final TextEditingController email;
  final TextEditingController password;
  final FocusNode heightFocus;
  final keyboardType;

  @override
  _CustomExpandedWithTextAndFormFieldState createState() =>
      _CustomExpandedWithTextAndFormFieldState();
}

class _CustomExpandedWithTextAndFormFieldState
    extends State<CustomExpandedWithTextAndFormField> {
  var storeUserName,
      userEmail,
      userMobileNo,
      standard1,
      token,
      profileImage,
      enrollmentNumber,
      school,
      academicYear,
      standardFromGetApi,
      googleId;
  final l = Logger();
  userdatas() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');

      storeUserName = userDetails[0];
      userEmail = userDetails[1];
      userMobileNo = userDetails[2];
      standard1 = userDetails[3];
      token = userDetails[5];
      profileImage = userDetails[4];
      enrollmentNumber = userDetails[7];
      school = userDetails[8];
      googleId = userDetails[6];
      academicYear = userDetails[9];
      standardFromGetApi = userDetails[10];
      print('$standardFromGetApi,47');
      widget.grade.text = standardFromGetApi.toString();
      widget.userName.text = storeUserName.toString();
      widget.email.text = userEmail.toString();
      widget.contactNumber.text = userMobileNo.toString();
      widget.enrollmentNumber.text =
          enrollmentNumber == "null" ? "" : enrollmentNumber.toString();
      widget.schoolName.text = school == "null" ? "" : school.toString();
      widget.academicYear.text =
          academicYear == "null" ? "" : academicYear.toString();

      l.wtf(academicYear);
    });
  }

  profileUpdateApi() async {
    var url = Uri.parse(profileUpdateApiCall);
    var response = await http.put(url, body: {
      'user_name': widget.userName.text.toString(),
      'email': widget.email.text.toString(),
      'phone': widget.contactNumber.text.toString(),
      'password': widget.password.text.toString(),
      'class': standard1,
      'enrollment_number': widget.enrollmentNumber.text.toString(),
      'school': widget.schoolName.text.toString(),
      'academic_year': widget.academicYear.text.toString()
    }, headers: {
      'Authorization': token
    });
    print(response.body);
    var editFullDetails = json.decode(response.body);
    var status = editFullDetails['status'];
    print("$editFullDetails,line 86");
    var userName = editFullDetails['result']['user_name'];
    var storeemail = editFullDetails['result']['email'];
    var phone = editFullDetails['result']['phone'];
    var standard = editFullDetails['result']['class'];
    print("$standard,hhhhhhhhhhhhhh");
    var enrollmentNumber = editFullDetails['result']['enrollment_number'];
    var school = editFullDetails['result']['school'];
    var academicYear = editFullDetails['result']['academic_year'];

    storingAllDetails(
        userName: userName,
        storeemail: storeemail,
        phone: phone,
        standard: standard,
        profileImage: profileImage,
        token: token,
        googleId: googleId,
        enrollmentNumber: enrollmentNumber,
        school: school,
        academicYear: academicYear,
        standardFromGetApi: standardFromGetApi);
    if (status == true) {
      final snackBar = SnackBar(
        backgroundColor: HexColor('#27AE60'),
        content: Text('Updated Successfully'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, 'helo');
    } else {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Something went wrong! please again update your datas'),
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
  void initState() {
    userdatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('69line');
    // userdatas();
    return Expanded(
      child: Container(
        // color: Colors.green,
        height: (widget.height - (2 * widget.status)) * 0.90,
        // padding: EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customText(width: widget.width, text: 'User Name'),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'User Name',
                prefixIcon: Icons.person,
                controller: widget.userName,
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.015,
              ),
              customText(width: widget.width, text: 'Enrollment Number'),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'Enrollment Number',
                prefixIcon: Icons.person,
                controller: widget.enrollmentNumber,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.015,
              ),
              customText(width: widget.width, text: "Grade"),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              // CustomSelectFormField(
              //   hintText: "Grade",
              //   width: widget.width,
              //   height: widget.height,
              //   controller: widget.grade,
              //   prefixIcon: Icons.grade_outlined,
              // ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'Grade',
                prefixIcon: Icons.grade_outlined,
                controller: widget.grade,
                readOnly: true,
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.015,
              ),
              customText(width: widget.width, text: "School Name"),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'School Name',
                prefixIcon: Icons.school,
                controller: widget.schoolName,
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.015,
              ),
              customText(width: widget.width, text: "Academic Year"),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'Academic Year',
                prefixIcon: Icons.school,
                suffixIcon: Icons.calendar_today,
                controller: widget.academicYear,
                value: 'calendar',
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.015,
              ),
              customText(width: widget.width, text: "Contact Number"),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'Contact Number',
                prefixIcon: Icons.phone,
                controller: widget.contactNumber,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.015,
              ),
              customText(width: widget.width, text: "Email"),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.005,
              ),
              CustomTextFormField(
                width: widget.width,
                height: widget.height,
                hintText: 'Email',
                prefixIcon: Icons.mail,
                controller: widget.email,
                readOnly: true,
              ),

              // CustomTextFormField(
              //   width: width,height: height,
              //   hintText: 'Password',
              //   prefixIcon: Icons.password,
              //   suffixIcon: Provider.of<ProviderFunction>(context, listen: true)
              //           .obsecure
              //       ? Icons.visibility
              //       : Icons.visibility_off,
              //   controller: password,
              //   focusNode: heightFocus,
              //   obsecure: Provider.of<ProviderFunction>(context, listen: true)
              //       .obsecure,
              //   value: 'visible',
              // ),

              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.05,
              ),
              Container(
                height: widget.height * 0.05,
                width: widget.width * 0.7,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    side: MaterialStateProperty.all(BorderSide()),
                    // fixedSize: MaterialStateProperty.all(
                    //   Size.fromWidth(width * 0.7),
                    // ),

                    // minimumSize: MaterialStateProperty.all(null),
                    // minimumSize: MaterialStateProperty.all(
                    //   Size.fromWidth(width * 0.7),
                    // ),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                  child: Text('Update'),
                  onPressed: () {
                    profileUpdateApi();
                  },
                ),
              ),
              SizedBox(
                height: (widget.height - (2 * widget.status)) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
