import 'package:flutter/material.dart';


class ProfileUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children:[
          Container(
    child: Row(
          children: [
            Icon( Icons.arrow_back),
            Text('Edit Profile'),
          ],
      )
    ),
        ]
    ),
    );
  }
}

