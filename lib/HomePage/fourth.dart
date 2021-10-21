import 'package:flutter/material.dart';

class Fourth extends StatefulWidget {
  const Fourth({Key? key}) : super(key: key);

  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Science")),
      // color: Colors.orange,
    );
  }
}
