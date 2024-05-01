import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/sem/eighth_sem.dart';
import 'package:kiit_connect/user/member/sem/seventh_sem.dart';

class MinorProject extends StatelessWidget {
  const MinorProject({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Objective")
        .addTextField("Teacher")
        .addTextField("Teacher Kiit Email Id")
        .addTextField("displayName")
        .addTextField("Your Role")
        .addTextField("PPT Link")
        .addFileUploadButton("MinorReport",
            type: FileType.custom,
            allowedExtensions: [
          "pdf"
        ]).build("Minor Project",(c) => const EightSemesterPerformance());
  }
}
