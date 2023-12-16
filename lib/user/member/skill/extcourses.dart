import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class ExtraCertifications extends StatelessWidget {
  const ExtraCertifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder("Extra Certifications", (c) => PersonalProject())
        .addTextField("Specialization")
        .addTextField("Organization")
        .addTextField("Certificate Link")
        .addTextField("Certificate Date ");
  }
}
