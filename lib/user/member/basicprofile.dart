import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiit_connect/theme/colors.dart';

import '../../navigation/drawer.dart';
import '../../theme/neo_box.dart';
import 'school/tenth_ac.dart';

class BasicProfile extends StatefulWidget {
  @override
  _BasicProfileState createState() => _BasicProfileState();
}

class _BasicProfileState extends State<BasicProfile> {
  final _formKey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _phonenumber = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  String? photoUrl;
  File? _selectedPhoto;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
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
    photoUrl = await storageRef.getDownloadURL(); // Update photoUrl with new URL
  }


  void _saveToFirestore() async {
    if (_selectedPhoto != null) {
      await _uploadPhotoToFirebase(_selectedPhoto!);

      final basicdata = {
        'name': _namecontroller.text,
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
          const SnackBar(content: Text('Basic Info Updated!!')),
        );
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TenthGradeInfo()),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save information')),
        );
      });
    }
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
      endDrawer: SideDrawer(),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                              image:_selectedPhoto != null
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
                        icon: Icons.person,
                        label: "Full Name",
                        controller: _namecontroller,
                      ),
                      MatTextField(
                        icon: Icons.email,
                        label: "Personal Email Address",
                        controller: _emailcontroller,
                      ),
                      MatTextField(
                        icon: Icons.phone,
                        label: "Phone Number",
                        controller: _phonenumber,
                      ),
                      MatTextField(
                        icon: Icons.home,
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
