import 'package:flutter/material.dart';

class First extends StatefulWidget {
  First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Recent")),
      // color: Colors.red,
    );
  }
}
