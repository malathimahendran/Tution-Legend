import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:tutionmaster/ALLROUTES/routesname.dart';
import 'package:tutionmaster/Login/loginpage.dart';
import 'package:tutionmaster/ProfilePage/logout.dart';

class Carosel extends StatefulWidget {
  Carosel({Key? key}) : super(key: key);

  @override
  _CaroselState createState() => _CaroselState();
}

class _CaroselState extends State<Carosel> {
  @override
  int currentPos = 0;
  List<String> listPaths = [
    'assets/Carousel/slide.png',
    'assets/Carousel/slide2.png',
  ];

  List<String> titles = [
    "Education is the passport to the future, for tomorrow belongs to those who prepare for it today.",
    "Education is the passport to the future, for tomorrow belongs to those who prepare for it today."
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
    double buttonText = 2;
    double subText = 1.8;
    return Scaffold(
        body: Container(
      height: height - status,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/ProfilePage/mainbackground.png'),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          Container(
            height: (height - status) * 0.30,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('assets/LoginPage/logintop.png'),
                    fit: BoxFit.fill)),
          ),
          Container(
            height: (height - status) * 0.70,
            width: width,
            child: Column(
              children: [
                CarouselSlider.builder(
                  itemCount: listPaths.length,
                  itemBuilder: (context, index, realIndex) {
                    return MyImageView(listPaths[index]);
                  },
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      initialPage: 0,
                      autoPlay: false,
                      height: 200.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPos = index;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: width * 0.6,
                    child: Text('${titles[currentPos]}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: unitHeightValue * subText,
                              color: HexColor('#707070')),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listPaths.map((url) {
                    int index = listPaths.indexOf(url);
                    print(index);
                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        child: Container(
                          width: 8.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: HexColor('#000000')),
                            shape: BoxShape.circle,
                            color: currentPos == index
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, AllRouteNames.loginpage);
                        // Navigator.pushReplacement(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             new LoginPage()));
                      },
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: unitHeightValue * buttonText)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              HexColor('#243665')),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;

    return Container(
        height: (height - status) * 0.60,
        width: width * 0.6,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            imgPath,
            height: height * 0.2,
          ),
        ));
  }
}
