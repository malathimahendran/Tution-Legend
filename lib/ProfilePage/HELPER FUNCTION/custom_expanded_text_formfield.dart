import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';
import 'custom_text_form_field.dart';
import 'provider_for_edit_page.dart';

class CustomExpandedWithTextAndFormField extends StatelessWidget {
  const CustomExpandedWithTextAndFormField({
    Key? key,
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.green,
        height: (height - (2 * status)) * 0.90,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customText(width: width, text: 'User Name'),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomTextFormField(
                width: width,
                hintText: 'User Name',
                prefixIcon: Icons.person,
                controller: userName,
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: 'Enrollment Number'),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomTextFormField(
                width: width,
                hintText: 'Enrollment Number',
                prefixIcon: Icons.person,
                controller: enrollmentNumber,
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: "Grade"),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomSelectFormField(
                hintText: "Grade",
                width: width,
                controller: grade,
                prefixIcon: Icons.grade_outlined,
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: "School Name"),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomTextFormField(
                width: width,
                hintText: 'School Name',
                prefixIcon: Icons.school,
                controller: schoolName,
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: "Academic Year"),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomTextFormField(
                width: width,
                hintText: 'Academic Year',
                prefixIcon: Icons.school,
                suffixIcon: Icons.calendar_today,
                controller: academicYear,
                value: 'calendar',
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: "Contact Number"),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomTextFormField(
                width: width,
                hintText: 'Contact Number',
                prefixIcon: Icons.phone,
                controller: contactNumber,
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: "Email"),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),
              CustomTextFormField(
                width: width,
                hintText: 'Email',
                prefixIcon: Icons.mail,
                controller: email,
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.015,
              ),
              customText(width: width, text: "Password"),
              SizedBox(
                height: (height - (2 * status)) * 0.005,
              ),

              // CustomTextFormField(
              //   width: width,
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
              Consumer<ProviderFunction>(
                builder: (context, child, _) {
                  return CustomTextFormField(
                    width: width,
                    hintText: 'Password',
                    prefixIcon: Icons.password,
                    suffixIcon: child.obsecure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    controller: password,
                    focusNode: heightFocus,
                    obsecure: child.obsecure,
                    value: 'visible',
                  );
                },
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.05,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  side: MaterialStateProperty.all(BorderSide()),
                  fixedSize: MaterialStateProperty.all(
                    Size.fromHeight(height * 0.06),
                  ),
                  maximumSize: MaterialStateProperty.all(
                    Size.fromWidth(width * 0.7),
                  ),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                child: Text('Update'),
                onPressed: () {},
              ),
              SizedBox(
                height: (height - (2 * status)) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
