import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  IconData navigationbaricon;
  String navigationbariconname;
  int iconIndex;
  int pageIndex;
  NavigationBar(
      {required this.navigationbaricon,
      required this.navigationbariconname,
      required this.iconIndex,
      required this.pageIndex});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (iconIndex != pageIndex)
          SizedBox(
            height: 18,
          ),

        Icon(
          navigationbaricon,
          size: 30,
          color: Colors.white,
        ),

        if (iconIndex != pageIndex)
          Text(navigationbariconname,
              style: TextStyle(
                color: Colors.white,
              ))
        // : Text(
        //     "  ",
        //     style: TextStyle(fontSize: 20),
        //   ),
      ],
    );
  }
}
