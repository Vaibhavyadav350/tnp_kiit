import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/skill/competency.dart';

import '../../home/HomePage.dart';

const PUBLIC_PROFILE_NAME = "Public Profile";
final PUBLIC_PROFILE_KEY = PUBLIC_PROFILE_NAME.toFormattableKey();

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Resume Link")
        .addTextField("Github Link")
        .addTextField("Linkedin Id")
        .addTextField("Others Link", maxLines: 2)
        .build(PUBLIC_PROFILE_NAME, (c) => const Competency(), firebaseKey: PUBLIC_PROFILE_KEY);
  }
}
