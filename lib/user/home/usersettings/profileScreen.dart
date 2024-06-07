import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiit_connect/theme/maintenance.dart';
import 'package:kiit_connect/user/home/usersettings/profileComponent/notification.dart';
import 'package:kiit_connect/user/home/usersettings/profileComponent/profilebutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/user/home/usersettings/profileComponent/settings.dart';
import 'package:kiit_connect/user/onboard/wrapper.dart';

import '../../member/setting/timeline.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? photoUrl;
  File? _selectedPhoto;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("PROFILE"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            GestureDetector(
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
                        FluentIcons.camera_add_48_regular,
                        size: 40,
                        color: Colors.purple,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: FluentIcons.person_accounts_24_regular,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Maintenance()));
              },
            ),
            ProfileMenu(
              text: "Validation",
              icon: FluentIcons.service_bell_24_regular,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimelineScreen()));
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: FluentIcons.alert_48_regular,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: FluentIcons.settings_48_regular,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppSettings()));
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: FluentIcons.chat_help_24_regular,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: FluentIcons.sign_out_24_regular,
              press: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
