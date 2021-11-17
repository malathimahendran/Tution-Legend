import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/ProfilePage/profilepage.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

import 'HELPER FUNCTION/custom_expanded_text_formfield.dart';
import 'HELPER FUNCTION/custom_text.dart';
import 'HELPER FUNCTION/custom_text_form_field.dart';
import 'HELPER FUNCTION/provider_for_edit_page.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController enrollmentNumber = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController schoolName = TextEditingController();
  TextEditingController academicYear = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FocusNode heightFocus = FocusNode();
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final status = MediaQuery.of(context).padding.top;
    final keyBoardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black,
              fontSize: height * 0.025,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('assets/RegisterPage/registerbackground.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            height: height - status,
            width: width,
            margin: EdgeInsets.only(top: status),
            padding: EdgeInsets.fromLTRB(10, status, 10, status),
            child: Column(
              children: [
                CustomExpandedWithTextAndFormField(
                    height: height,
                    status: status,
                    width: width,
                    userName: userName,
                    enrollmentNumber: enrollmentNumber,
                    grade: grade,
                    schoolName: schoolName,
                    academicYear: academicYear,
                    contactNumber: contactNumber,
                    email: email,
                    password: password,
                    heightFocus: heightFocus,
                    keyboardType: keyboardType),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
