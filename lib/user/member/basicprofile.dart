import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'dart:math' as Math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../drawer/drawer.dart';
import '../../theme/neo_box.dart';
import 'education.dart';

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
  List<String> photoUrls = [];
  List<File?> _selectedPhotos = [];
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
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
    _namecontroller.text = data['name'] ?? '';
    _phonenumber.text = data['phone'] ?? '';
    _emailcontroller.text = data['email'] ?? '';
    _addresscontroller.text = data['address'] ?? '';
    photoUrls = List<String>.from(data['photoUrls'] ?? []);

  }
  Future<List<String>> _uploadPhotosToFirebase() async {


    for (var photo in _selectedPhotos) {
      if (photo != null) {
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('professional_photo')
            .child(DateTime.now().millisecondsSinceEpoch.toString());

        final UploadTask uploadTask = storageRef.putFile(photo);
        await uploadTask.whenComplete(() {});
        final photoUrl = await storageRef.getDownloadURL();
        photoUrls.add(photoUrl);
      }
    }
    return photoUrls;
  }

  void _saveToFirestore() async {
    List<String> photoUrls = await _uploadPhotosToFirebase();

    final basicdata = {
      'name': _namecontroller.text,
      'phone': _phonenumber.text,
      'email': _emailcontroller.text,
      'address': _addresscontroller.text,
      'photoUrls': photoUrls,
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
        MaterialPageRoute(builder: (context) => EducationDetails()),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save information')),
      );
    });
  }

  Future<void> _pickPhotosFromGallery() async {
    final picker = ImagePicker();

    List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _selectedPhotos = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SideDrawer(),
      backgroundColor: Colors.grey[300],
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeoBox(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            // Handle back button pressed
                          },
                        ),
                      ),
                    ),
                    const Text(
                      "BASIC PROFILE",
                      style: TextStyle(letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeoBox(
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: _openDrawer,
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => _pickPhotosFromGallery(),
                        child: Text('Pick Photos'),
                      ),
                      SizedBox(height: 30),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: _selectedPhotos.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return _selectedPhotos[index] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(_selectedPhotos[index]!))
                              : Placeholder();
                        },
                      ),
                      NeoBox(
                        child: TextFormField(
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _phonenumber,
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                              labelText: 'Personal Email',
                              border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the  Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _addresscontroller,
                          decoration: const InputDecoration(
                              labelText: 'Address', border: InputBorder.none),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {

                              if (_formKey.currentState!.validate()) {
                                _saveToFirestore();
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Proceed'),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
