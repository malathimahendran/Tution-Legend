// import 'package:appbar_example/main.dart';
// import 'package:flutter/material.dart';

// class SimpleAppBarPage extends StatefulWidget {
//   @override
//   _SimpleAppBarPageState createState() => _SimpleAppBarPageState();
// }

// class _SimpleAppBarPageState extends State<SimpleAppBarPage> {
//   @override
//   Widget build(BuildContext context) => DefaultTabController(
//         length: 4,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(MyApp1.title),
//             //centerTitle: true,
//             leading: IconButton(
//               icon: Icon(Icons.menu),
//               onPressed: () {},
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.notifications_none),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {},
//               )
//             ],
//             //backgroundColor: Colors.purple,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.purple, Colors.red],
//                   begin: Alignment.bottomRight,
//                   end: Alignment.topLeft,
//                 ),
//               ),
//             ),
//             bottom: TabBar(
//               //isScrollable: true,
//               indicatorColor: Colors.white,
//               indicatorWeight: 5,
//               tabs: [
//                 Tab(icon: Icon(Icons.home), text: 'Home'),
//                 Tab(icon: Icon(Icons.star), text: 'Feed'),
//                 Tab(icon: Icon(Icons.face), text: 'Profile'),
//                 Tab(icon: Icon(Icons.settings), text: 'Settings'),
//               ],
//             ),
//             elevation: 20,
//             titleSpacing: 20,
//           ),
//           body: TabBarView(
//             children: [
//               buildPage('Home Page'),
//               buildPage('Feed Page'),
//               buildPage('Profile Page'),
//               buildPage('Settings Page'),
//             ],
//           ),
//         ),
//       );

//   Widget buildPage(String text) => Center(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 28),
//         ),
//       );
// }
import 'package:flutter/material.dart';

void main() => runApp(MyApp1());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/HomeScreenPage/homescreentab.png'),
                fit: BoxFit.fill),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), title: Text('title')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.remove), title: Text('title')),
            ],
          ),
        ),
      ),
    );
  }
}
