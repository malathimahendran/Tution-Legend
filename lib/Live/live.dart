import 'package:flutter/material.dart';

class Live extends StatefulWidget {
  Live({Key? key}) : super(key: key);

  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Center(
            child: Text(
          "Coming Soon...",
          style: TextStyle(color: Colors.black),
        )),
      ),
    );
  }
}
