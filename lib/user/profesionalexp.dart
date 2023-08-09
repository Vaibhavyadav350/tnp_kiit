import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../drawer/drawer.dart';
import '../theme/neo_box.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormFields {
  TextEditingController roleController = TextEditingController();
  TextEditingController stipendController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController supportedDocController = TextEditingController();
  TextEditingController bankStatement = TextEditingController();
  bool showStipendField = false;
}

class ProfessionalExperience extends StatefulWidget {
  @override
  _ProfessionalExperienceState createState() => _ProfessionalExperienceState();
}

class _ProfessionalExperienceState extends State<ProfessionalExperience> {
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

    List<dynamic> data =
        docSnap.get('ProfessionalExperiences') as List<dynamic>;
    _formsList = data.map((item) {
      Map<String, dynamic> experience = item as Map<String, dynamic>;
      FormFields formFields = FormFields();
      formFields.roleController.text = experience['Role'] ?? '';
      formFields.companyController.text = experience['Company'] ?? '';
      formFields.stipendController.text = experience['Stipend'] ?? '';
      formFields.monthController.text = experience['Months'] ?? '';
      formFields.descriptionController.text = experience['Description'] ?? '';
      formFields.supportedDocController.text = experience['SupportedDoc'] ?? '';
      formFields.bankStatement.text = experience['BankStatement'] ?? '';
      return formFields;
    }).toList();

    setState(() {});
  }

  Future<String?> pickAndUploadSupportedDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('docs/${DateTime.now().toIso8601String()}.pdf');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } else {
      // User canceled the picker
      return null;
    }
  }

  Future<String?> pickAndUploadBankStatement() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('docs/${DateTime.now().toIso8601String()}.pdf');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } else {
      // User canceled the picker
      return null;
    }
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> proexp = [];

    for (int i = 0; i < _formsList.length; i++) {
      final FormFields formFields = _formsList[i];
      final CollegeExp = {
        'Role': formFields.roleController.text,
        'Company': formFields.companyController.text,
        'SupportedDoc': formFields.supportedDocController.text,
        'Description': formFields.descriptionController.text,
        'Stipend': formFields.stipendController.text,
        'Months': formFields.monthController.text,
        'BankStatement': formFields.monthController.text,
      };

      proexp.add(CollegeExp);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'ProfessionalExperiences': proexp}, SetOptions(merge: true)).then(
            (documentRef) {
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
        title: const Text('Professional Experience'),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _formsList.length,
                itemBuilder: (context, index) {
                  return buildForm(index);
                },
              ),
            ],
          ),
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
          controller: _formsList[index].companyController,
          decoration: const InputDecoration(labelText: 'Company'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Company Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsList[index].monthController,
          decoration: const InputDecoration(labelText: 'Months'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter number of Months';
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
        ElevatedButton(
          onPressed: () {
            setState(() {
              _formsList[index].showStipendField =
                  !_formsList[index].showStipendField; // toggle the field visibility
            });
          },
          child: const Text('Paid'),
        ),
        if (_formsList[index].showStipendField) ...[
          TextFormField(
            controller: _formsList[index].stipendController,
            decoration: const InputDecoration(labelText: 'Stipend'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Stipend Amount';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              String? url = await pickAndUploadSupportedDoc();
              if (url != null) {
                _formsList[index].supportedDocController.text = url;
                setState(() {}); // to refresh the UI
              }
            },
            child: const Text('Select Supported Document'),
          ),
          ElevatedButton(
            onPressed: () async {
              String? url = await pickAndUploadBankStatement();
              if (url != null) {
                _formsList[index].bankStatement.text = url;
                setState(() {}); // to refresh the UI
              }
            },
            child: const Text('Select Bank Statement'),
          ),
        ],
        ElevatedButton(
          onPressed: () => deleteForm(index),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
