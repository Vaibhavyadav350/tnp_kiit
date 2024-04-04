import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UploadDataPage extends StatefulWidget {
  @override
  _UploadDataPageState createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  Map<String, bool> _fieldValues = {
    'Basic Personal Details': false,
    'Academic Details': false,
    'Technical Skills and Expertise': false,
    'Workshops, Courses, and Certifications': false,
    'Internships and Professional Experience': false,
    'Personal Projects': false,
    'Extracurricular Activities': false,
    'Achievements and Awards': false,
    'Language Proficiency': false,
    'Recommendations and Testimonials': false,
    'Research Papers and Publications': false,
    'Competitive Programming Platforms': false,
    'Open Source Contributions': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildCheckboxes(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadData,
        child: Icon(Icons.save),
      ),
    );
  }

  List<Widget> _buildCheckboxes() {
    List<Widget> checkboxes = [];
    _fieldValues.forEach((fieldName, isChecked) {
      checkboxes.add(
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  _fieldValues[fieldName] = value!;
                });
              },
            ),
            Text(fieldName),
          ],
        ),
      );
    });
    return checkboxes;
  }

  Future<void> _uploadData() async {
    try {
      Map<String, dynamic> data = {};
      _fieldValues.forEach((fieldName, isChecked) {
        data[fieldName] = {'completed': isChecked};
      });

      await FirebaseFirestore.instance.collection('StudentInfo').doc(FirebaseAuth.instance.currentUser?.uid).set(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data uploaded successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error uploading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

}
