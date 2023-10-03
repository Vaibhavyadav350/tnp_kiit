import 'package:flutter/material.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasicProfile(),
    );
  }
}
