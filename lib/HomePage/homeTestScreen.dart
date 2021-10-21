import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';

class HomeTestScreen extends StatefulWidget {
  HomeTestScreen({Key? key}) : super(key: key);

  @override
  _HomeTestScreenState createState() => _HomeTestScreenState();
}

class _HomeTestScreenState extends State<HomeTestScreen> {
  var userName;

  getUserName() {
    Shared().shared().then((value) async {
      var userDetails = await value.getStringList('storeData');
      setState(() {
        userName = userDetails[0];
        print(userName);
      });

      print(userDetails);
      print(28);
    });
  }

  List<String> subjectList = [
    "Maths",
    "Science",
    "Biology",
    "Chemistry",
    "physics",
    "Zoology",
    "Botany"
  ];

  int selectedIndex = 0;
  String selectedSubject = '';
  @override
  void initState() {
    super.initState();
    getUserName();
    selectedSubject = subjectList[0];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var status = MediaQuery.of(context).padding.top;
    var bottom = kBottomNavigationBarHeight;
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/ProfilePage/mainbackground.png'),
          )),
          child: Column(children: [
            Container(
              // color: Colors.blue,
              height: (height - (status + bottom)) * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/HomeScreenPage/menu.png',
                    height: 20,
                  ),
                  Text(
                    '$userName',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Icon(Icons.person)
                ],
              ),
            ),
            Container(
              // color: Colors.red,
              height: (height - (status + bottom)) * 0.25,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/HomeScreenPage/homecard.png'),
                  )),
                  height: (height - status) * 0.25,
                  width: width * 0.9,
                ),
                Positioned(
                  bottom: height * 0.12,
                  child: Text(
                    '       Start\n       Learning',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white)),
                  ),
                ),
                Positioned(
                  bottom: height * 0.02,
                  left: width * 0.07,
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.6,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'What you want to learn',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        // icon: Icon(Icons.search),
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 11, color: HexColor('#7B7777'))),
                        // prefixIcon: icon,
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: HexColor('#27DEBF'))),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(subjectList.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedSubject = subjectList[index];
                        selectedIndex = index;
                        print(selectedSubject);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: index == selectedIndex
                              ? Colors.green
                              : Colors.grey[350],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            subjectList[index],
                            style: TextStyle(
                                color: index == selectedIndex
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              height: (height - (status + bottom)) * 0.47,
              child: Center(child: Text("$selectedSubject")),
            ),
          ])),
    ));
  }
}
