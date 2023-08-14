import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static List<Color> colors = [
    Colors.grey,
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.lime,
    Colors.green,
    Colors.blueGrey,
    Colors.pink,
  ];

  static const textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide.none,
  );

  static final buttonStyle = IconButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
