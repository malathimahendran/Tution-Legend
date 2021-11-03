import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final status = MediaQuery.of(context).padding.top;
    final keyBoardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBody: true,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            // color: Colors.green,
            child: Image.asset(
              'assets/ProfilePage/mainbackground.png',
              height: !keyBoardVisible ? height : height * 0.5,
              // width: width,
            ),
          ),
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(top: status),
            alignment: Alignment.topCenter,
            child: Image.asset('assets/LoginPage/logintop.png'),
          ),
          Container(
            height: height - status,
            width: width,
            margin: EdgeInsets.only(top: status),
            padding: EdgeInsets.fromLTRB(10, status, 10, status),
            child: Column(
              children: [
                Container(
                  height: (height - (2 * status)) * 0.07,
                  width: width,
                  // color: Colors.orange,
                  child: Row(
                    children: [
                      Container(
                        width: (width - 20) * 0.37,
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back),
                      ),
                      Container(
                        width: (width - 20) * 0.63,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: (height - (2 * status)) * 0.02,
                ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
