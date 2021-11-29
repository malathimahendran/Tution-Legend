import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/Login/loginpage.dart';

class Changepassword extends StatefulWidget {
  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool secureText = true;
  bool secureText1 = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print(height);
    var width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "New Password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/FORGOTPASSWORD/changepassword.png",
                  width: (width - 90)),
              Text(
                "Enter the new password then \n    your password will change.\n          Don't forget again.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                width: width * 0.7,
                child: TextFormField(
                  obscureText: secureText1,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: HexColor("#0A4E51"), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: HexColor("#0A4E51"), width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: width * 0.7,
                child: TextFormField(
                  obscureText: secureText,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
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
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(color: HexColor("#0A4E51"), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(color: HexColor("#0A4E51"), width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                width: (width * 0.5) - 20,
                height: (height * 0.09) - 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Done',
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
    );
  }
}
