import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/videos/likeandunlikeapi.dart';

class StartLearning extends StatefulWidget {
  StartLearning({Key? key}) : super(key: key);

  @override
  _StartLearningState createState() => _StartLearningState();
}

class _StartLearningState extends State<StartLearning> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        // color: HexColor('#FB94A0'),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/StartLearning/startLearningBackground.png'),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: height * 0.4,
                width: width * 0.8,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //             'assets/StartLearning/startlearning.png'),
                //         fit: BoxFit.fill)),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: height * 0.3,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("    Learn anytime\n    and anywhere",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        )),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "    Perfect time to spent\n    your day to learn something\n    new everyday anywhere.",
                      style: GoogleFonts.poppins(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.15,
            ),
            Container(
              width: width * 0.8,
              // height: height * 0.1,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/homescreen');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'Start Learning',
                    style: GoogleFonts.poppins(),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor('#243665')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )))),
            )
          ],
        ),
      ),
    );
  }
}
