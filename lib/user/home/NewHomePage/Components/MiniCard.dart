// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

Widget miniCard({
  required String title,
  required String imgPath,
  required double height,
  required double width,
}) {
  return Container(
    padding: EdgeInsets.all(20),
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.fill),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title)
      ],
    ),
  );
}
