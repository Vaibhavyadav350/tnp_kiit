import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';

class SemesterReport extends StatelessWidget {
  final int semesterNumber;
  String ast = "";
  final Widget Function(BuildContext) nextPage;

  SemesterReport(this.semesterNumber, this.nextPage, {super.key}) {
    ast = ["st", "nd", "rd", "th"][min(semesterNumber - 1, 3)];
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("SGPA",
            icon: Icons.equalizer,
            keyboardType: const TextInputType.numberWithOptions(decimal: true))
        .addTextField("CGPA",
            icon: Icons.equalizer,
            keyboardType: const TextInputType.numberWithOptions(decimal: true))
        .addTextField("Marksheet Link",
            icon: Icons.link, keyboardType: TextInputType.url)
        .addTextField("Co-Curricular Activities",
            icon: Icons.library_books, keyboardType: TextInputType.url)
        .addTextField("Extra-Curricular Activities",
            icon: Icons.star, keyboardType: TextInputType.url)
        .addTextField("Volunteering Activities",
            icon: Icons.group, keyboardType: TextInputType.url)
        .limitMaximumInstancesTo(1)
        .build("$semesterNumber$ast Semester Performance", nextPage);
  }
}
