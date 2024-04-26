import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiit_connect/user/member/chat/vybutton_.dart';
import 'package:kiit_connect/theme/vytext.dart';

import '../../../theme/colors.dart';


class UploadProjectPage extends StatefulWidget {
  const UploadProjectPage({super.key});

  @override
  _UploadProjectPageState createState() => _UploadProjectPageState();
}

class _UploadProjectPageState extends State<UploadProjectPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _linksController = TextEditingController();
  File? _imageFile;
  final picker = ImagePicker();
  String? _userEmail;
  String? _userimage;// Added to save the user's email

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email;
        _userimage = user.photoURL;
      });
      print('User Email: $_userEmail');
    }
  }



  Future<void> _pickImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('project_images/${_imageFile!.path.split('/').last}');
      await ref.putFile(_imageFile!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> _uploadProject() async {
    final imageUrl = await _uploadImage();
    String projectName = _nameController.text.trim();
    String projectDescription = _descriptionController.text.trim();
    List<String> tags = _tagsController.text.trim().isEmpty
        ? []
        : _tagsController.text.trim().split(',');
    String? status =
    _statusController.text.trim().isEmpty ? null : _statusController.text.trim();
    List<String> links = _linksController.text.trim().isEmpty
        ? []
        : _linksController.text.trim().split(',');

    // Check if projectName or projectDescription is empty
    if (projectName.isEmpty || projectDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  AwesomeSnackbarContent(
            title: 'Oh No!!',
            message: 'ProjectName and ProjectDescription are required',
            contentType: ContentType.failure,
          ),
          backgroundColor: Colors.transparent, // Set your desired color
        ),
      );
      return; // Exit the method
    }

    try {
      await FirebaseFirestore.instance.collection('projects').add({
        'projectName': projectName,
        'projectDescription': projectDescription,
        'imageUrl': imageUrl,
        'tags': tags,
        'status': status,
        'links': links,
        'uploaded_by_image':_userimage,
        'uploaded_by': _userEmail,
        'uplaodTime': DateTime.now()
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!!',
            message: 'Project $projectName uploaded successfully to TNP Social',
            contentType: ContentType.success,
          ),
        ),
      );
      _nameController.clear();
      _descriptionController.clear();
      _tagsController.clear();
      _statusController.clear();
      _linksController.clear();

      setState(() {
        _imageFile = null;
      });
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload project: $error')));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smallSpacing(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("    Post Your Projects!", style: textTitle(context)),
              ],
            ),
            smallSpacing(),
            Center(
              child: GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(75),
                    image: _imageFile != null
                        ? DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: _imageFile == null
                      ? Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: Colors.grey[600],
                  )
                      : null,
                ),
              ),
            ),
            VyText(_nameController, 'Project Name', Icons.title),
            VyText(_descriptionController, 'Project Description', Icons.description),
            // _imageFile != null
            //     ? Center(child: SizedBox(height:200,width:250,child: Image.file(_imageFile!)))
            //     : Center(child: VyButton('Pick Image', Icons.image, _pickImage)),
            VyText(_tagsController, 'Tags (comma-separated)', Icons.tag),
            VyText(_statusController, 'Status', Icons.info),
            VyText(_linksController, 'Links (comma-separated)', Icons.link),
            Center(child: VyButton('Upload Project', Icons.upload, _uploadProject)),

          ],
        ),
      ),
    );
  }
}






