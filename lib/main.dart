import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:kiit_connect/user/home/HomePage.dart';
import 'package:kiit_connect/user/home/NewHomePage/NewHomePage.dart';
import 'package:kiit_connect/user/home/nav/newbottom.dart';
import 'package:kiit_connect/user/home/nav/newhomescreen.dart';
import 'package:kiit_connect/user/onboard/wrapper.dart';
import 'package:kiit_connect/theme/colors.dart';

import 'navigation/bottomapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } on PlatformException {
    print(
        "WARNING: Firebase not connected. If you are testing, ignore this message.");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ColorProfile.instance =
        ColorProfile.dark(const Color.fromARGB(255, 62, 108, 154));
    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: greenHighlight,
        background: ColorProfile().background,
        primary: Colors.white70,
        primaryContainer: ColorProfile().background,
        secondary: Colors.white70,
        secondaryContainer: darkHighlight,
        tertiary: greenHighlight,
      ),
      cardColor: greenHighlight,
      useMaterial3: true,
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'T&P KIIT',
        theme: theme,
        darkTheme: theme.copyWith(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: MyNewBottomNavBar());
  }
}
