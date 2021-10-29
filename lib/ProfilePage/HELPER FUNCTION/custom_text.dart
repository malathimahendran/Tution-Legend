import 'package:flutter/material.dart';

Padding customText({text, width}) {
  return Padding(
    padding: EdgeInsets.only(left: (width! * 0.1)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
      ),
    ),
  );
}
