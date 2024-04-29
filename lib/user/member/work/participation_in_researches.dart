import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

const referenceTypes = [
  'Bill',
  'Book',
  'Book Section',
  'Case',
  'Computer Program',
  'Conference Proceedings',
  'Encyclopedia Article',
  'Film',
  'Hearing',
  'Journal Article',
  'Magazine Article',
  'Newspaper Article',
  'Patent',
  'Report',
  'Statute',
  'Television Broadcast',
  'Thesis',
  'Unspecified',
  'Web Page',
  'Working Paper'
];

class AcademicAchievements extends StatelessWidget {
  const AcademicAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addComboBox("Reference Type", referenceTypes,
        defaultValue: "Journal Article")
        .addMultiTextBox("Author Names")
        .addTextField("Title")
        .addTextField("Year of Publication", keyboardType: TextInputType.number)
        .addTextField("URL (Publication or PDF)", firebaseKey: "URL")
        .addTextField("Identifier (DOI/ArXivID/ISBN)", firebaseKey: "Identifier")
    .build("Academic Achievements", (c) => const PersonalProject());
  }
}
