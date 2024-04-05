// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/skill/competency.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import '../../../theme/neo_box.dart';

import '../../screens/RevampedHomePage.dart';
import '../../screens/home.dart';

class ProfessionalExperience extends StatelessWidget {
  const ProfessionalExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addComboBox("Competency", CompetencyLevel.types)
        .addMultiSelectComboBox("Skills", domainsSkill)
        .addTextField("Role")
        .addFileUploadButton("Supporting Document", type: FileType.custom, allowedExtensions: ["pdf"])
        .addTextField("Company")
        .addTextField("Duration")
        .addTextField("Starting Date")
        .addTextField("Description")
        .addCheckbox("Is It Paid")
        .addTextField("Stipend", validatingCondition: fieldEquals("Is It Paid", true), keyboardType: TextInputType.number)
        .addTextField("Bank Statement", validatingCondition: fieldEquals("Is It Paid", true))
        .build("Professional Experience", (c) => PersonalProject());
  }
}