import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiit_connect/user/member/sem/seventh_sem.dart';

import '../../../theme/utils/builder/ui_builder.dart';
import 'eighth_sem.dart';

class MajorProject extends StatelessWidget {
  const MajorProject({super.key});

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
