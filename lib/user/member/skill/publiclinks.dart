import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/screens/HomePage.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Resume Link")
        .addTextField("Github Link")
        .addTextField("Linkedin Id")
        .addTextField("Others Link", maxLines: 2)
        .build("Public Profile", (c) => const HomePage());
  }
}
