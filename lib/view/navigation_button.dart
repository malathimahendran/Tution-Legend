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
    return Padding(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: [
          Icon(
            navigationbaricon,
            size: 25,
            color: Colors.white,
          ),
          // SizedBox(height: 5.0),
          iconIndex != pageIndex
              ? Text(navigationbariconname,
                  style: TextStyle(
                    color: Colors.white,
                  ))
              : Text(
                  "  ",
                  style: TextStyle(fontSize: 20),
                ),
        ],
      ),
    );
  }
}
