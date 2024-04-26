import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

enum ContributionType {
  Code,
  Documentation,
  Design;

  static final types =
      ContributionType.values.map((e) => e.toString().substring(17)).toList();
}

const documentProcessors = [
  'MS Word',
  'Markdown',
  'Latex',
];

const interfaceDesigners = [
  'Figma',
  'MS Paint',
];

class OpenSourceContributions extends StatelessWidget {
  const OpenSourceContributions({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Project Name")
        .addTextField("Description", maxLines: 2)
        .addComboBox("Contribution Type", ContributionType.types)
        .addComboBox("Primary Language", domainsSkill,
            validatingCondition: fieldEquals("Contribution Type", "Code"))
        .addComboBox("Document Processor", documentProcessors,
            validatingCondition: fieldEquals("Contribution Type", "Documentation"))
        .addComboBox("Interface Designer", interfaceDesigners,
            validatingCondition: fieldEquals("Contribution Type", "Design"))
        .addTextField("Repository Link")
        .addTextField("Commit URL")
        .build("Open Source Contributions", (c) => const PersonalProject());
  }
}
