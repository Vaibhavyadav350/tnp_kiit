import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

enum ProficiencyLevel {
  ElementaryProficiency,
  LimitedWorkingProficiency,
  FullProfessionalProficiency,
  NativeOrBilingualProficiency;

  static final types = ProficiencyLevel.values
      .map((e) => e.toString().substring(17).keywordToSentence())
      .toList();
}

class LanguageProficiency extends StatelessWidget {
  const LanguageProficiency({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Language Name")
        .addComboBox("Proficiency Level", ProficiencyLevel.types)
        .build("Language Proficiency", (c) => const PersonalProject());
  }
}
