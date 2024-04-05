import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/screens/RevampedHomePage.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Resume Link")
        .addTextField("Github Link")
        .addTextField("Linkedin Id")
        .addTextField("Others Link", maxLines: 2)
        .build("Public Profile", (c) => RevampedHome());
  }
}
