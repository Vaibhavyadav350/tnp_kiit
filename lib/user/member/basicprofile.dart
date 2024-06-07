import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiit_connect/theme/colors.dart';

import '../../navigation/drawer.dart';
import '../../theme/utils/text/neo_box.dart';
import 'school/tenth_ac.dart';

class BasicProfile extends StatefulWidget {
  const BasicProfile({super.key});

  @override
  _BasicProfileState createState() => _BasicProfileState();
}

class _BasicProfileState extends State<BasicProfile> {
  final _formKey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _rollcontroller = TextEditingController();
  final _yearcontroller = TextEditingController();
  final _phonenumber = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  String? photoUrl;
  File? _selectedPhoto;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
    _rollcontroller.addListener(() {
      print("YIYOYOYO" + _rollcontroller.text);
      if (_rollcontroller.text.length >= 2)
        _yearcontroller.text =
            (int.parse(_rollcontroller.text.substring(0, 2)) + 2000).toString();
    });
    _fetchFromFirestore();
  }

  Future<void> _fetchFromFirestore() async {
    if (Firebase.apps.isEmpty) return;
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
    _namecontroller.text = data['name'] ?? '';
    _rollcontroller.text = data['roll'] ?? '';
    _yearcontroller.text = data['year'] ?? '';
    _phonenumber.text = data['phone'] ?? '';
    _emailcontroller.text = data['email'] ?? '';
    _addresscontroller.text = data['address'] ?? '';
    setState(() {
      photoUrl = data['photoUrl'];
    });
  }

  Future<void> _uploadPhotoToFirebase(File photo) async {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('professional_photo')
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    final UploadTask uploadTask = storageRef.putFile(photo);
    await uploadTask.whenComplete(() {});
    photoUrl =
        await storageRef.getDownloadURL(); // Update photoUrl with new URL
  }

  void _saveToFirestore() async {
    if (_selectedPhoto != null) {
      await _uploadPhotoToFirebase(_selectedPhoto!);
    }
    final basicdata = {
      'name': _namecontroller.text,
      'roll': _rollcontroller.text,
      'year': _yearcontroller.text,
      'phone': _phonenumber.text,
      'email': _emailcontroller.text,
      'address': _addresscontroller.text,
      'photoUrl': photoUrl,
    };
    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(basicdata)
        .then((documentRef) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!!',
            message: 'Basic Profile Info Saved',
            contentType: ContentType.success,
          ),
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TenthGradeInfo()),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh No!!',
            message: 'Failed to Save Data!',
            contentType: ContentType.failure,
          ),
        ),
      );
    });
  }

  Future<void> _pickPhotoFromGallery() async {
    final picker = ImagePicker();
    try {
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedPhoto = File(pickedFile.path);
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideDrawer(),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: padWrap(
            Column(
              children: [
                smallSpacing(),
                moveCenter([
                  Image.asset(
                    "assets/images/tnpkiit.png",
                    width: 200,
                  )
                ]),
                Text(
                  "Basic Information",
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 30,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      smallSpacing(),
                      Center(
                        child: GestureDetector(
                          onTap: _pickPhotoFromGallery,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              image: _selectedPhoto != null
                                  ? DecorationImage(
                                      image: FileImage(_selectedPhoto!),
                                      fit: BoxFit.cover,
                                    )
                                  : photoUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(photoUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                            ),
                            child: _selectedPhoto == null && photoUrl == null
                                ? Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey[600],
                                  )
                                : null,
                          ),
                        ),
                      ),
                      smallSpacing(),
                      MatTextField(
                        icon: FluentIcons.person_48_regular,
                        label: "Full Name",
                        controller: _namecontroller,
                      ),
                      MatTextField(
                        icon: FluentIcons.fingerprint_48_regular,
                        label: "Roll Number",
                        controller: _rollcontroller,
                        keyboardType: TextInputType.number,
                      ),
                      MatTextField(
                        icon: FluentIcons.calendar_48_regular,
                        label: "Joining Year",
                        controller: _yearcontroller,
                        keyboardType: TextInputType.number,
                      ),
                      MatTextField(
                        icon: FluentIcons.mail_48_regular,
                        label: "Personal Email Address",
                        controller: _emailcontroller,
                      ),
                      MatTextField(
                        icon: FluentIcons.call_48_regular,
                        label: "Phone Number",
                        controller: _phonenumber,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      MatTextField(
                        icon: FluentIcons.home_48_regular,
                        label: "Address",
                        controller: _addresscontroller,
                        maxLines: 3,
                      ),
                      smallSpacing(),
                      MatTextButton(
                        text: "Proceed",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveToFirestore();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pad: 16.0,
          ),
        ),
      ),
    );
  }
}
