import 'package:flutter/material.dart';

AppBar customAppBar(titleTxt) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Text(
      '$titleTxt',
      style: TextStyle(fontSize: 16.0),
    ),
  );
}
