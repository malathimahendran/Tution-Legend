// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

// import 'package:logger/logger.dart';
// import 'package:tutionmaster/SHARED%20PREFERENCES/shared_preferences.dart';


// class DrawerPage extends StatefulWidget {
//   DrawerPage({this.textForDrawer});
//   final textForDrawer;

//   @override
//   _DrawerPageState createState() => _DrawerPageState();
// }

// class _DrawerPageState extends State<DrawerPage> {
//   var networkImage;
//   var postedImage;
//   var image;
//   var profilePicture;

//   var imageFileNameFromResponseApi;
//   var imageName;
//   var logger = Logger();
//   bool isLoggedIn = true;
//   var receiverPic, nive, receiverFromRegister1, nive1;
//   @override
//   void initState() {
//     super.initState();
//     save();
//   }

//   save() async {
//     await Shared().shared().then((value) {
//       receiverPic = value.getStringList('storeData');

//       logger.w(receiverPic[0]);
//       logger.w(receiverPic[1]);

//       setState(() {
//         nive = receiverPic[2];
//         nive1 = receiverPic[3];
//         networkImage = receiverPic[4];
//         logger.w(networkImage);
//       });

//       logger.wtf("drawer page");

//       logger.w(nive1);
//       logger.w(nive);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     double fixedHeight = height > 1000
//         ? 80
//         : height > 900
//             ? 70
//             : height > 800
//                 ? 70
//                 : height > 700
//                     ? 70
//                     : 60;
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text(nive ??= ""),
//             accountEmail: Text(""),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.teal[400],
//               child: Text("Hi"),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).pop();
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => HomeScreen()));
//             },
//             leading: Image.asset('assets/Drawer/homeicon.png'),
//             title: Text("Home", style: TextStyle(color: Colors.teal[800])),
//           ),
//           Divider(height: 10.0, color: Colors.transparent),
//           ListTile(
//             onTap: () {
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (context) => null));
//             },
//             leading: Image.asset('assets/Drawer/message.png'),
//             title: Text("Message", style: TextStyle(color: Colors.teal[800])),
//           ),
//           Divider(height: 10.0, color: Colors.transparent),
//           ListTile(
//             onTap: () {
//               Navigator.of(context).pop();
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (context) => TreeAdd()));
//             },
//             leading: Image.asset('assets/Drawer/treee.png'),
//             title:
//                 Text("Family Tree", style: TextStyle(color: Colors.teal[800])),
//           ),
//           Divider(height: 10.0, color: Colors.transparent),
//           ListTile(
//             onTap: () {
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (context) => null));
//             },
//             leading: Image.asset('assets/Drawer/mapicon.png'),
//             title: Text(
//               "Location",
//               style: TextStyle(color: Colors.teal[800]),
//             ),
//           ),
//           Divider(height: 10.0, color: Colors.transparent),
//           ListTile(
//             onTap: () {
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (context) => null));
//             },
//             leading: Image.asset('assets/Drawer/accounticon.png'),
//             title: Text("Account", style: TextStyle(color: Colors.teal[800])),
//           ),
//           Divider(height: 10.0, color: Colors.transparent),
//           ListTile(
//             onTap: () {
//               Log
//               // LogOutForAll.outTemporary(context);
//             },
//             leading: Image.asset('assets/Drawer/logoutt.png'),
//             title: Text("Logout", style: TextStyle(color: Colors.teal[800])),
//           ),
//           Divider(height: 10.0, color: Colors.transparent),
//         ],
//       ),
//     );
//   }

//   chooseImage(source) async {
//     var pickedFile = await ImagePicker().pickImage(source: source);
//     setState(() {
//       imageFile = File(pickedFile.path);
//       print(pickedFile.path);
//       imageName = imageFile.path.split("/").last.toString();
//     });
//     return imageFile;
//   }

//   postImage(imageFiles) async {
//     logger.w(imageFiles);
//     final String url = "https://www.cviacserver.tk/parampara/v1/images";
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(
//       await http.MultipartFile.fromPath('myFile', imageFiles.path),
//     );
//     var res = await request.send();
//     var response = await http.Response.fromStream(res);

//     postedImage = json.decode(response.body);
//     logger.d(postedImage);

//     setState(() {
//       imageFileNameFromResponseApi = postedImage['image']['filename'];
//       logger.w(imageFileNameFromResponseApi);
//       logger.w(imageFile);
//     });
//   }
// }
