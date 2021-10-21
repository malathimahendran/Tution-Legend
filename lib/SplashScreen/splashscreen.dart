// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:shimmer/shimmer.dart';

// class SplashScreen extends StatefulWidget {
//   SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       child: Center(
//         child: Container(
//           child: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               // Opacity(
//               //   opacity: 0.5,
//               //   child: Image.asset('assests/images/tree.jpg'),
//               // ),
//               Shimmer.fromColors(
//                   period: Duration(seconds: 4),
//                   baseColor: Colors.white,
//                   highlightColor: Colors.white,
//                   child: Container(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text("Tution Legend",
//                         style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                           fontSize: 25.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.pink,
//                           // fontFamily: 'Pacifico',
//                         ))),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
