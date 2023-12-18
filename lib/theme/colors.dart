import 'dart:math';

import 'package:flutter/material.dart';

const darkBackground = Color(0xFF041D19);
const mains1 = Color(0xFF2F904D);
const mains2 = Color(0xFF295E16);
const mains3 = Color(0xFF93F337);
const mains4 = Color(0xFF3CFBF3);
const mains5 = Color(0xFF2DBDB6);
const darks1 = Color(0xFF297F14);
const darks2 = Color(0xFF2F7424);
const darks3 = Color(0xFF29E364);
const darks4 = Color(0xFF20BD62);
const darks5 = Color(0xFF228C87);

const roots1 = Color(0xFF29E364);
const roots2 = Color(0xFFB9F340);
const roots3 = Color(0xFF39F3A9);
const roots4 = Color(0xFF3CFBF3);

final randomGenerator = Random();


class StatefulColorChain {
  final colors = [
    [roots1, roots2],
    [roots2, roots3],
    [roots3, roots4]
  ]
      .expand((p) => List.generate(5, (i) => i / 4.0)
          .map((f) => Color.lerp(p[0], p[1], f)))
      .map((c) => [c!.withAlpha(40), c.withAlpha(10)])
      .toList();
  int index = 0;

  StatefulColorChain() {
    colors.shuffle();
  }

  List<Color> next() => colors[(index++) % colors.length];
}

extension ThemeRadialGradient on RadialGradient {
  static RadialGradient random(colors) => RadialGradient(
      center: Alignment(
        (randomGenerator.nextDouble() - 0.5) * 3,
        (randomGenerator.nextDouble() - 0.5) * 3,
      ),
      radius: 1.5,
      colors: colors);
}

//
const darkShadow = Color.fromARGB(255, 1, 22, 30); //color scheme changed
const darkHighlight = Color.fromARGB(255, 18, 69, 89); //color scheme changed
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

Widget boxWrap(widget, {padding, color}) {
  padding = padding ?? const EdgeInsets.fromLTRB(20, 8, 20, 10);
  color = color ?? darkHighlight;
  return Container(
    padding: padding,
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

TextStyle textTitle(context, {color}) {
  color ??= Theme.of(context).secondaryHeaderColor;
  return TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold);
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
