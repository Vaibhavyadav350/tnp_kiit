import 'package:flutter/material.dart';
import 'package:kiit_connect/page/mainpage.dart';
import 'package:kiit_connect/service/wrapper.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kiit_connect/user/member/education.dart';
import 'package:kiit_connect/user/member/profesionalexp.dart';
import 'package:kiit_connect/user/newscreens/basicdetails.dart';
import 'package:kiit_connect/user/newscreens/home.dart';

import 'user/newscreens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T&P KIIT',
      home: NewHomePage(),
    );
  }
}
