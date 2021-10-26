import 'package:flutter/material.dart';

class Third extends StatefulWidget {
  Third({Key? key}) : super(key: key);

  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Maths")),
      // color: Colors.green,
    );
  }
}
