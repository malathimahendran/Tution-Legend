import 'package:flutter/material.dart';

import 'drawer_page.dart';

class TestOne extends StatefulWidget {
  @override
  _TestOneState createState() => _TestOneState();
}

class _TestOneState extends State<TestOne> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test One'),
        ),
        key: scaffoldKey,
        drawer: DrawerPage(),
        bottomNavigationBar: Container(
          height: 56.0,
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.add),
              Icon(Icons.add),
              Icon(Icons.add),
            ],
          ),
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(
              child: Text('click'),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
        ));
  }
}
