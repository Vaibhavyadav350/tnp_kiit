// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/skill/competency.dart';
import 'package:kiit_connect/user/member/work/projects.dart';


class ProfessionalExperience extends StatelessWidget {
  const ProfessionalExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addComboBox("Professional Experience", CompetencyLevel.types)
        .addMultiSelectComboBox("Skills", domainsSkill)
        .addTextField("Role")
        .addFileUploadButton("Supporting Document", type: FileType.custom, allowedExtensions: ["pdf"])
        .addTextField("Company")
        .addTextField("From Date",hintText: "dd/mm/yy")
        .addTextField("To Date",hintText: "dd/mm/yy")
        .addTextField("Starting Date")
        .addTextField("Description")
        .addCheckbox("Is It Paid")
        .addTextField("Stipend", validatingCondition: fieldEquals("Is It Paid", true), keyboardType: TextInputType.number)
        .addTextField("Bank Statement", validatingCondition: fieldEquals("Is It Paid", true))
        .build("Professional Experience", (c) => PersonalProject());
  }
}