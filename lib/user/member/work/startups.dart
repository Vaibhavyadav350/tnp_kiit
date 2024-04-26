import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class StartupInformation extends StatelessWidget {
  const StartupInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Name")
        .addMultiTextBox("Founder Names")
        .addTextField("Inception Date")
        .addTextField("Description", maxLines: 4)
        .addTextField("Industry")
        .addTextField("USP", maxLines: 2)
        .addTextField("Revenue Model")
        .build("Startup Information", (c) => const PersonalProject());
  }
}
