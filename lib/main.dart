import 'package:flutter/material.dart';
import 'package:kiit_connect/service/wrapper.dart';
import 'package:kiit_connect/user/basicprofile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kiit_connect/user/collegeexp.dart';
import 'package:kiit_connect/user/education.dart';
import 'package:kiit_connect/user/profesionalexp.dart';
import 'package:kiit_connect/user/projects.dart';
import 'package:kiit_connect/user/publiclinks.dart';
import 'home.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PublicProfile(),
    );
  }
}