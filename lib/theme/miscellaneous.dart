import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> pickAndUploadSupportedDoc(
    {FileType type = FileType.any, List<String>? allowedExtensions}) async {

  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: type, allowedExtensions: allowedExtensions);

  if (result == null) {
    // User canceled the picker
    return null;
  }

  File file = File(result.files.single.path!);
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('docs/${DateTime.now().toIso8601String()}.pdf');
  await ref.putFile(file);
  return await ref.getDownloadURL();
}
