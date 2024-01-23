import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/neo_box.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/newscreens/home.dart';

class FormFields {
  TextEditingController nameController = TextEditingController();
  List<TextEditingController> founderNameControllers = [
    TextEditingController()
  ];
  TextEditingController inceptionDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController uspController = TextEditingController();
  TextEditingController revenueModelController = TextEditingController();
}

class StartupInformation extends StatelessWidget {
  const StartupInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder("Startup Information", (c) => PersonalProject())
        .addTextField("Name")
        .addMultiTextBox("Founder Names")
        .addTextField("Inception Date")
        .addTextField("Description", maxLines: 4)
        .addTextField("Industry")
        .addTextField("USP", maxLines: 2)
        .addTextField("Revenue Model");
  }
}