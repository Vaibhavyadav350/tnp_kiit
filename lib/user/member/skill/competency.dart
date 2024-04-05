import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

enum CompetencyLevel {
  Introductory,
  Beginner,
  Intermediate,
  Professional;

  static final types = CompetencyLevel.values
      .map((e) => e.toString().substring(16).keywordToSentence())
      .toList();
}

class Competency extends StatelessWidget {
  const Competency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addComboBox("Competency", CompetencyLevel.types)
        .addMultiSelectComboBox("Skills", domainsSkill)
        .limitMaximumInstancesTo(CompetencyLevel.types.length)
        .build("Skills", (c) => ProfessionalExperience());
  }
}
