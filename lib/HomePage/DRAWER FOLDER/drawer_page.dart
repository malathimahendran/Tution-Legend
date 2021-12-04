import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:tutionmaster/HomePage/changepassword.dart';
import 'package:tutionmaster/Payment%20Screens/paymentDesign.dart';
import 'package:tutionmaster/Payment%20Screens/paymenttry.dart';

class DrawerPage extends StatefulWidget {
  final double? height;
  final double? width;
  final double? status;
  final String? profileImage;
  final String? enrollmentNumber;
  final String? storeUserName;
  final String? userName;
  DrawerPage(
      {this.height,
      this.width,
      this.status,
      this.profileImage,
      this.enrollmentNumber,
      this.storeUserName,
      this.userName});
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final l = Logger();
  @override
  Widget build(BuildContext context) {
    l.v(widget.profileImage);
    l.v(widget.userName);
    return Drawer(
        child: Column(children: [
      Container(
        color: HexColor('#009688'),
        // width: width * 0.9,
        height: widget.height! * 0.2,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              // color: Colors.green,

              child: widget.profileImage == null ||
                      widget.profileImage == "" ||
                      widget.profileImage!.isEmpty
                  ? Container(
                      height: (widget.height! - widget.status!) * 0.08,
                      width: widget.width! * 0.15,
                      color: Colors.redAccent[400],
                      alignment: Alignment.center,
                      child: Text(
                        widget.storeUserName
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ))
                  : Image.network(widget.profileImage!),
            ),
            SizedBox(width: widget.width! * 0.04),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.storeUserName! == null ? "" : widget.storeUserName!,
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                  Container(
                    child: Text('Student',
                        style: GoogleFonts.poppins(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 12))),
                  ),
                  Container(
                    child: widget.enrollmentNumber! == "null"
                        ? Text('')
                        : Text('Enrollment no:${widget.enrollmentNumber!}',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 13))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        width: widget.width! * 0.9,
        height: widget.height! * 0.6,
        child: Column(
          children: [
            SizedBox(
              height: widget.height! * 0.03,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentDesign()));
              },
              child: Container(
                width: widget.width! * 0.65,
                height: widget.height! * 0.075,
                child: Row(
                  children: [
                    SizedBox(
                      width: widget.width! * 0.04,
                    ),
                    Icon(Icons.payment, color: HexColor('#3F3F3F')),
                    SizedBox(
                      width: widget.width! * 0.03,
                    ),
                    Text('Payments',
                        style: GoogleFonts.poppins(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 13)))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: widget.height! * 0.01,
            ),
            Container(
              width: widget.width! * 0.65,
              height: widget.height! * 0.075,
              child: Row(
                children: [
                  SizedBox(
                    width: widget.width! * 0.04,
                  ),
                  Icon(Icons.lock, color: HexColor('#3F3F3F')),
                  SizedBox(
                    width: widget.width! * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Passwordchange()));
                    },
                    child: Text('ChangePassword',
                        style: GoogleFonts.poppins(
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 13))),
                  )
                ],
              ),
            ),
            SizedBox(
              height: widget.height! * 0.01,
            ),
            Container(
              width: widget.width! * 0.65,
              height: widget.height! * 0.075,
              child: Row(
                children: [
                  SizedBox(
                    width: widget.width! * 0.04,
                  ),
                  Icon(
                    Icons.help,
                    color: HexColor('#3F3F3F'),
                  ),
                  SizedBox(
                    width: widget.width! * 0.03,
                  ),
                  Text('Help and Support',
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 13)))
                ],
              ),
            )
          ],
        ),
      )
    ]));
  }
}
