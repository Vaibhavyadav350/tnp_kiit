import 'package:flutter/cupertino.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/home/HomePage.dart';

class Noc extends StatelessWidget {
  const Noc({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Company Name")
        .addTextField("Your Role")
        .addTextField("From Date",hintText: "dd/mm/yy")
        .addTextField("To Date",hintText: "dd/mm/yy")
        .addTextField("Offer Letter Link")
        .addTextField("Stipend")
        .build("NOC", (c) => const HomePage());
  }
}
