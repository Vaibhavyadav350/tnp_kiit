import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiit_connect/navigation/bottomapp.dart';
import 'package:kiit_connect/service/wrapper.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:kiit_connect/user/member/work/college_experience.dart';
import 'package:kiit_connect/user/member/work/language_proficiency.dart';
import 'package:kiit_connect/user/member/work/open_source_contributions.dart';
import 'package:kiit_connect/user/member/work/participation_in_researches.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/onboard/splash.dart';
import 'package:kiit_connect/user/screens/RevampedHomePage.dart';


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
    ColorProfile.instance =
        ColorProfile.dark(Color.fromARGB(255, 62, 108, 154));
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
      title: 'T&P KIIT',
      theme: theme,
      darkTheme: theme.copyWith(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: Wrapper(),
    );
  }
}
