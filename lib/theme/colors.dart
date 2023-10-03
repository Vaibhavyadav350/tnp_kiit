import 'package:flutter/material.dart';

//
const darkShadow = Color.fromARGB(255, 33, 40, 50);
const darkHighlight = Color.fromARGB(255, 80, 97, 109);
const greenHighlight = Color.fromARGB(255, 23, 208, 89);

// const primary = Color(0xFF007dff);
const primary = Color.fromARGB(255, 255, 255, 255);
const mainColor = Color(0x802FB484);
const secondary = Color(0xFFe54140);
const greyyy = Color(0xFFE0E0E0);
const appBgColor = Color(0xFFbdc0f7);
const bgcolor = Color.fromARGB(
  255,
  33,
  40,
  50,
);
const appBgColorSecondary = Color.fromARGB(255, 255, 82, 82);
const appBgColorTernary = Colors.yellow;
const loginPrimary = Colors.black;
const loginSecondary = Colors.green;
const bottomBarBgColor = Color(0xFFEEEEEE);
const inActiveIcon = Color(0xFFABBEEC);
const upColor = Color(0xFF4bc46d);
const downColor = Colors.red;
const stayColor = Colors.black87;
const shadowColor = Colors.black87;
const bottomBarColor = Color(0xFFF8FCFD);
const buttoncolor = Color.fromARGB(
  255,
  254,
  211,
  106,
);
const kiitgreen = Color.fromARGB(
  255,
  23,
  208,
  89,
);
const textfieldcolor = Color.fromARGB(
  255,
  69,
  90,
  100,
);

Widget padWrap(widget, {pad}) {
  return Padding(
    padding: EdgeInsets.all(pad ?? 8.0),
    child: widget,
  );
}

Widget boxWrap(widget, {color}) {
  color = color ?? darkHighlight;
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
    // TODO: Use theme data
    decoration: BoxDecoration(
      color: color,
    ),
    child: widget,
  );
}

TextStyle textAnnotation(context, {color}) {
  color ??= Theme.of(context).primaryColor;
  return TextStyle(color: color, fontSize: 20);
}

Widget smallSpacing() {
  return const SizedBox(height: 30);
}

Widget moveCenter(widgets) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: widgets,
  );
}
