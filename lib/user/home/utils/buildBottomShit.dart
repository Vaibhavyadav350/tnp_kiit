// ignore_for_file: prefer_const_constructors

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/sem/eighth_sem.dart';
import 'package:kiit_connect/user/member/sem/fifth_sem.dart';
import 'package:kiit_connect/user/member/sem/first_sem.dart';
import 'package:kiit_connect/user/member/sem/fourth_sem.dart';
import 'package:kiit_connect/user/member/sem/majorproject.dart';
import 'package:kiit_connect/user/member/sem/minorproject.dart';
import 'package:kiit_connect/user/member/sem/second_sem.dart';
import 'package:kiit_connect/user/member/sem/seventh_sem.dart';
import 'package:kiit_connect/user/member/sem/sixth_sem.dart';
import 'package:kiit_connect/user/member/sem/third_sem.dart';

Widget buildModalBottomSheet(BuildContext context) {
  return SingleChildScrollView(
    child: Wrap(
      children: [
        buildListTile(context, 'Semester 1', FirstSemesterPerformance()),
        buildListTile(context, 'Semester 2', SecondSemesterPerformance()),
        buildListTile(context, 'Semester 3', ThirdSemesterPerformance()),
        buildListTile(context, 'Semester 4', FourthSemesterPerformance()),
        buildListTile(context, 'Semester 5', FifthSemesterPerformance()),
        buildListTile(context, 'Semester 6', SixthSemesterPerformance()),
        buildListTile(context, 'Minor Project', MinorProject()),
        buildListTile(context, 'Semester 7', SeventhSemesterPerformance()),
        buildListTile(context, 'Major Project', MajorProject()),
        buildListTile(context, 'Semester 8', EightSemesterPerformance()),
      ],
    ),
  );
}

Widget buildListTile(BuildContext context, String title, Widget destination) {
  return ListTile(
    leading: Icon(
      FluentIcons.book_32_regular,
      color: Colors.black,
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
  );
}
