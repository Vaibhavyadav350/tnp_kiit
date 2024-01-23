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
  const OpenSourceContributions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder("Open Source Contributions", (c) => PersonalProject())
        .addTextField("Project Name")
        .addTextField("Description", maxLines: 2)
        .addComboBox("Contribution Type", ContributionType.types)
        .addComboBox("Primary Language", domainsSkill)
        .addConditional(field: "Contribution Type", condition: "Code")
        .addComboBox("Document Processor", documentProcessors)
        .addConditional(field: "Contribution Type", condition: "Documentation")
        .addComboBox("Interface Designer", interfaceDesigners)
        .addConditional(field: "Contribution Type", condition: "Design")
        .addTextField("Repository Link")
        .addTextField("A Link to your Commit");
  }
}
