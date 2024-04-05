import 'dart:math';

import 'package:flutter/material.dart';

Color highlight(color) {
  return HSLColor.fromColor(color).withSaturation(1).toColor();
}

Color variant(color, {hueShift = 0, target = 0, britShift = 0}) {
  final variant = HSLColor.fromColor(color);
  return variant
      .withHue((variant.hue + hueShift) % 360.0)
      .withLightness(
      variant.lightness + (target - variant.lightness) * britShift)
      .toColor();
}

/// Generate a non random color profile.
/// Tip: Give bright but not fully saturated colors as roots.
class ColorProfile {
  static ColorProfile? instance;

  factory ColorProfile() => instance!;

  final Color background;
  final Color mains1;
  final Color mains2;
  final Color mains3;
  final Color mains4;
  final Color mains5;
  final Color darks1;
  final Color darks2;
  final Color darks3;
  final Color darks4;
  final Color darks5;

  final Color roots1;
  final Color roots2;
  final Color roots3;
  final Color roots4;

  final randomGenerator = Random();

  late final List<List<Color>> _colors;
  late final ColorFilter _mains1Filter;

  List<List<Color>> get colors {
    final cols = _colors.toList();
    cols.shuffle(randomGenerator);
    return cols;
  }

  void _postProcess() {
    _colors = [
      [roots1, roots2],
      [roots2, roots3],
      [roots3, roots4]
    ]
        .expand((p) =>
        List.generate(5, (i) => i / 4.0)
            .map((f) => Color.lerp(p[0], p[1], f)))
        .map((c) => [c!.withAlpha(40), c.withAlpha(10)])
        .toList();
    _mains1Filter = imageTransformationMatrix(target: mains1);
  }

  ColorProfile.dark(Color root)
      : background = variant(root, britShift: 0.85),
        mains1 = root,
        mains2 = variant(root, britShift: 0.2),
        mains3 = variant(root, hueShift: -50),
        mains4 = variant(root, hueShift: 40),
        mains5 = variant(root, britShift: 0.4, hueShift: 30),
        darks1 = variant(root, britShift: 0.5),
        darks2 = variant(root, britShift: 0.6),
        darks3 = variant(root, britShift: 0.4, hueShift: -50),
        darks4 = variant(root, britShift: 0.4, hueShift: 40),
        darks5 = variant(root, britShift: 0.6, hueShift: 30),
        roots1 = highlight(root),
        roots2 = variant(highlight(root), hueShift: -50),
        roots3 = variant(highlight(root), hueShift: 20),
        roots4 = variant(highlight(root), hueShift: 40) {
    _postProcess();
  }

  // TODO: Implement the following shit
  //  ColorProfile.light(Color root)

  Gradient randomRadialGradient(colors) =>
      RadialGradient(
          center: Alignment(
            (randomGenerator.nextDouble() - 0.5) * 3,
            (randomGenerator.nextDouble() - 0.5) * 3,
          ),
          radius: 1.5,
          colors: colors);

  ColorFilter imageTransformationMatrix({Color? target, double factor = 0.7}) {
    if (target == null) return _mains1Filter;
    final inverse = 1 - factor;
    return ColorFilter.matrix(<double>[
      factor, 0.0, 0.0, 0.0, inverse * target.red,
      0.0, factor, 0.0, 0.0, inverse * target.green,
      0.0, 0.0, factor, 0.0, inverse * target.blue,
      //
      0.0, 0.0, 0.0, 1.0, 0.0,
    ]);
  }
}

class StatefulColorChain {
  final colors;
  int index = 0;

  StatefulColorChain(ColorProfile profile) : colors = profile.colors;

  List<Color> next() => colors[(index++) % colors.length];
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
const starBgColor = Color(0xFFf49452);
const kPrimaryColor = Color(0xFF2e2947);
Color offWhite = Color(0xFFFFFFF0); // Off-White
Color beige = Color(0xFFF5F5DC); // Beige
Color lightGray = Color(0xFFD3D3D3); // Light Gray
Color paleBlue = Color(0xFFAFEEEE); // Pale Blue
Color palePink = Color(0xFFFFDAB9); // Pale Pink
Color paleYellow = Color(0xFFFFFF99); // Pale Yellow
Color mintGreen = Color(0xFF98FB98); // Mint Green
Color lavender = Color(0xFFE6E6FA); // Lavender
Color peach = Color(0xFFFFDAB9); // Peach
Color lightTaupe = Color(0xFFBEBD7F); // Light Taupe


const appBgColorSecondary = Color.fromARGB(255, 255, 82, 82);
const appBgColorTernary = Colors.yellow;
const loginPrimary = Colors.black;
const loginSecondary = Colors.green;
const bottomBarBgColor = Color(0xFFEEEEEE);
const inActiveIcon = Color(0xFFABBEEC);
const boardcolor1 = Color(0x00f8f8ff);
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

Widget boxWrap(widget, {padding, color, height}) {
  padding = padding ?? const EdgeInsets.fromLTRB(20, 8, 20, 10);
  color = color ?? darkHighlight;
  return Container(
    padding: padding,
    // TODO: Use theme data
    height: height,
    decoration: BoxDecoration(
      color: color,
    ),
    child: widget,
  );
}

TextStyle textAnnotation(context, {color, height}) {
  color ??= Theme
      .of(context)
      .primaryColor;
  return TextStyle(color: color, fontSize: 20, height: height);
}

TextStyle textTitle(context, {color}) {
  color ??= Theme
      .of(context)
      .secondaryHeaderColor;
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

InputDecoration inputDecoration({label="", icon}) {
  return InputDecoration(
    labelStyle: TextStyle(color: Colors.white),
    labelText: label,
    prefixIcon: Icon(icon, color: Colors.green),
    fillColor: Colors.green.withOpacity(0.1),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
    ),
  );
}

