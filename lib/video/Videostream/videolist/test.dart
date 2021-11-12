import 'package:flutter/material.dart';
class Test extends StatelessWidget {
  String text;
  Test({ required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('$text'));
  }
}

