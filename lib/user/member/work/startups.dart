import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

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
    return FormBuilder()
        .addTextField("Name")
        .addMultiTextBox("Founder Names")
        .addTextField("Inception Date")
        .addTextField("Description", maxLines: 4)
        .addTextField("Industry")
        .addTextField("USP", maxLines: 2)
        .addTextField("Revenue Model")
        .build("Startup Information", (c) => PersonalProject());
  }
}
