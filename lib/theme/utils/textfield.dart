import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';

Widget customTextField({required String hintText}) {
  IconData? iconData;

  switch (hintText) {
    case 'Name':
      iconData = Icons.person_2_outlined;
      break;
      case 'Personal Email':
      iconData = Icons.mail_outline;
      break;
    case 'Address':
      iconData = Icons.home_outlined;
      break;
    case 'Phone Number':
      iconData = Icons.phone_outlined;
      break;
    default:
      iconData = null;
      break;
  }
  return TextField(

    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Color.fromARGB(255, 69, 90, 100),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded edges here
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Keep edges rounded when field is focused
        borderSide: BorderSide(color: kiitgreen),
      ),
      prefixIcon: iconData != null ? Icon(iconData, color: Colors.white) : null,
    ),
    style: TextStyle(
      color: Colors.white,
    ),
  );
}