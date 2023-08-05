import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({Key? key}) : super(key: key);

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  TextEditingController _resumeController = TextEditingController();
  TextEditingController _githubController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _othersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TextFormField(
              controller: _resumeController,
              decoration: const InputDecoration(labelText: 'Resume Link'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Resume Link';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _githubController,
              decoration: const InputDecoration(labelText: 'Github Link'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Github Link';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _linkedinController,
              decoration: const InputDecoration(labelText: 'Linkedin Id'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Linkedin Link';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _othersController,
              decoration: const InputDecoration(labelText: 'Others'),
            ),
          ],
        ),
      ),
    );
  }
}
