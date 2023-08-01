import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../drawer/drawer.dart';
import '../theme/neo_box.dart';

class FormFields {
  TextEditingController roleController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController supportedDocController = TextEditingController();
}

class CollegeExperience extends StatefulWidget {
  @override
  _CollegeExperienceState createState() => _CollegeExperienceState();
}

class _CollegeExperienceState extends State<CollegeExperience> {
  final _formKey = GlobalKey<FormState>();

  List<FormFields> _formsList = [];

  void addForm() {
    _formsList.add(FormFields());
    setState(() {});
  }

  void deleteForm(int index) {
    _formsList.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    fetchFromFirestore();
    addForm();
  }

  Future<void> fetchFromFirestore() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    List<dynamic> data = docSnap.get('CollegeExperiences') as List<dynamic>;
    _formsList = data.map((item) {
      Map<String, dynamic> experience = item as Map<String, dynamic>;
      FormFields formFields = FormFields();
      formFields.roleController.text = experience['Role'] ?? '';
      formFields.societyController.text = experience['Society'] ?? '';
      formFields.descriptionController.text = experience['Description'] ?? '';
      formFields.supportedDocController.text = experience['SupportedDoc'] ?? '';
      return formFields;
    }).toList();

    setState(() {});
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> collegeExperiences = [];

    for (int i = 0; i < _formsList.length; i++) {
      final FormFields formFields = _formsList[i];
      final CollegeExp = {
        'Role': formFields.roleController.text,
        'Society': formFields.societyController.text,
        'SupportedDoc': formFields.supportedDocController.text,
        'Description': formFields.descriptionController.text,
      };

      collegeExperiences.add(CollegeExp);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'CollegeExperiences': collegeExperiences},
            SetOptions(merge: true)).then((documentRef) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Info Updated!!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save information')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('College Experience'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addForm,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                saveToFirestore();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: _formsList.length,
          itemBuilder: (context, index) {
            return buildForm(index);
          },
        ),
      ),
    );
  }

  Widget buildForm(int index) {
    return Column(
      children: [
        TextFormField(
          controller: _formsList[index].roleController,
          decoration: InputDecoration(labelText: 'Role'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Role Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsList[index].societyController,
          decoration: InputDecoration(labelText: 'Society'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Society Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsList[index].descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Description';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsList[index].supportedDocController,
          decoration:
              const InputDecoration(labelText: 'Supported Documents Links'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Documents Links';
            }
            return null;
          },
        ),
        ElevatedButton(
          onPressed: () => deleteForm(index),
          child: Text('Delete'),
        ),
      ],
    );
  }
}
