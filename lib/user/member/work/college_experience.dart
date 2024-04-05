import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/skill/competency.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class CollegeExperience extends StatelessWidget {
  const CollegeExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Society Name")
        .addTextField("Description", maxLines: 2)
        .addTextField("Reference Document")
        .addMultiSelectComboBox("Skills", domainsSkill)
        .build("College Experience", (c) => PersonalProject());
  }
}
