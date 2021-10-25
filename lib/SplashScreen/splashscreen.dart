import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/HomePage/homescreen.dart';
import 'package:tutionmaster/Slider/carosalSlider.dart';

import '../SHARED PREFERENCES/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final l = Logger();
  var selectHere;
  @override
  void initState() {
    super.initState();

    selectingHere().whenComplete(() {
      Future.delayed(Duration(seconds: 2), () {
        l.i('insideselectinghere');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             selectHere == null ? Carosel() : HomeScreen()));
        Navigator.popAndPushNamed(
            context,
            selectHere == null
                ? AllRouteNames.carosalSlider
                : AllRouteNames.homescreen);
      });
    });
  }

  Future selectingHere() async {
    await Shared().shared().then((val) {
      selectHere = val.getStringList('storeData');
      print(selectHere);
      // l.wtf('in splashscreen selectingHereFunction');
    });

    // var shared = await SharedPreferences.getInstance();
    // setState(() {
    //   selectHere = shared.getStringList('pic');
    // });
    // print(selectHere);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(
        top: status,
      ),
      height: height,
      width: width,
      child: Column(
        children: [
          Container(
            height: (height - status) * 0.5,
          ),
          Container(
            height: (height - status) * 0.5,
            child: Column(
              children: [
                // Container(
                //   child: Image.asset(''),
                // ),
                Shimmer.fromColors(
                  period: Duration(seconds: 4),
                  baseColor: Colors.green,
                  highlightColor: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('TUITION',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 22.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontFamily: 'Pacifico',
                          ))),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Text('LEGEND',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 22.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontFamily: 'Pacifico',
                          )))
                    ],
                  ),
                )
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [Text('TUITION'), Text('LEGEND')],
          // )
        ],
      ),
    ));
  }
}
