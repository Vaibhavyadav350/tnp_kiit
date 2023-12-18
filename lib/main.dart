import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiit_connect/service/wrapper.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:kiit_connect/user/newscreens/home.dart';
import 'package:kiit_connect/user/test_screens/RevampedHomePage.dart';
import 'package:kiit_connect/user/test_screens/navBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } on PlatformException {
    print(
        "WARNING: Firebase not connected. If you are testing, ignore this message.");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: greenHighlight,
        background: darkBackground,
        primary: Colors.white70,
        primaryContainer: darkBackground,
        secondary: Colors.white70,
        secondaryContainer: darkHighlight,
        tertiary: greenHighlight,
      ),
      cardColor: greenHighlight,
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'T&P KIIT',
      theme: theme,
      darkTheme: theme.copyWith(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,

      home: RevampedHome(),
    );
  }
}
