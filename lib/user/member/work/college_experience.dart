import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/work/language_proficiency.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class CollegeExperience extends StatelessWidget {
  const CollegeExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Society Name")
        .addTextField("Position")
        .addTextField("Description", maxLines: 2)
        .addTextField("Reference Document Link")
        .addMultiSelectComboBox("Skills", domainsSkill)
        .build("College Experience", (c) => const LanguageProficiency());
  }
}
