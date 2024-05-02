import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/work/open_source_contributions.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class ExtraCertifications extends StatelessWidget {
  const ExtraCertifications({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Specialization")
        .addTextField("Organization")
        .addTextField("Certificate Link")
        .addTextField("Certificate Date ")
        .build("Extra Certifications", (c) => const OpenSourceContributions());
  }
}
