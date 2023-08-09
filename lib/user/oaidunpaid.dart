import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../drawer/drawer.dart';
import '../theme/neo_box.dart';

class FormFields {

  TextEditingController roleController = TextEditingController();
  TextEditingController stipendController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController supportedDocController = TextEditingController();
}

class ProfessionalExperience extends StatefulWidget {
  @override
  _ProfessionalExperienceState createState() => _ProfessionalExperienceState();
}

class _ProfessionalExperienceState extends State<ProfessionalExperience> {
  final _formKeypaid = GlobalKey<FormState>();
  final _formKeyunpaid = GlobalKey<FormState>();

  List<FormFields> _formsListpaid = [];
  List<FormFields> _formsListunpaid = [];

  void addPaidForm() {
    _formsListpaid.add(FormFields());
    setState(() {});
  }

  void addUnpaidForm() {
    _formsListunpaid.add(FormFields());
    setState(() {});
  }

  void deletePaidForm(int index) {
    _formsListpaid.removeAt(index);
    setState(() {});
  }

  void deleteUnpaidForm(int index) {
    _formsListunpaid.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    fetchFromFirestore();
    addPaidForm();
    addUnpaidForm();
  }

  Future<void> fetchFromFirestore() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    List<dynamic> data =
    docSnap.get('ProfessionalExperiences') as List<dynamic>;
    _formsListpaid = data.map((item) {
      Map<String, dynamic> experience = item as Map<String, dynamic>;
      FormFields formFields = FormFields();
      formFields.roleController.text = experience['Role'] ?? '';
      formFields.companyController.text = experience['Company'] ?? '';
      formFields.stipendController.text = experience['Stipend'] ?? '';
      formFields.monthController.text = experience['Months'] ?? '';
      formFields.descriptionController.text = experience['Description'] ?? '';
      formFields.supportedDocController.text = experience['SupportedDoc'] ?? '';
      return formFields;
    }).toList();

    setState(() {});
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> proexp = [];

    for (int i = 0; i < _formsListpaid.length; i++) {
      final FormFields formFields = _formsListpaid[i];
      final CollegeExp = {
        'Role': formFields.roleController.text,
        'Company': formFields.companyController.text,
        'SupportedDoc': formFields.supportedDocController.text,
        'Description': formFields.descriptionController.text,
        'Stipend': formFields.stipendController.text,
        'Months': formFields.monthController.text,
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
        title: const Text('Professional '),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addPaidForm,
          ),IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: addUnpaidForm,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKeypaid.currentState!.validate()) {
                saveToFirestore();
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _formsListpaid.length + _formsListunpaid.length,
        itemBuilder: (context, index) {
          if (index < _formsListpaid.length) {
            return buildPaidForm(index);
          } else {
            return buildUnpaidForm(index - _formsListpaid.length);
          }
        },
      ),
    );
  }

  Widget buildPaidForm(int index) {
    return Column(
      children: [
        TextFormField(
          controller: _formsListpaid[index].roleController,
          decoration: InputDecoration(labelText: 'Role'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Role Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListpaid[index].companyController,
          decoration: const InputDecoration(labelText: 'Company'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Company Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListpaid[index].stipendController,
          decoration: const InputDecoration(labelText: 'Stipend'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Stipend Amount';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListpaid[index].monthController,
          decoration: const InputDecoration(labelText: 'Months'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter number of Months';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListpaid[index].descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Description';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListpaid[index].supportedDocController,
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
          onPressed: () => deletePaidForm(index),
          child: Text('Delete'),
        ),
      ],
    );
  }
  Widget buildUnpaidForm(int index) {
    return Column(
      children: [
        TextFormField(
          controller: _formsListunpaid[index].roleController,
          decoration: InputDecoration(labelText: 'Role'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Role Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListunpaid[index].companyController,
          decoration: const InputDecoration(labelText: 'Company'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Company Name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListunpaid[index].stipendController,
          decoration: const InputDecoration(labelText: 'Stipend'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Stipend Amount';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListunpaid[index].monthController,
          decoration: const InputDecoration(labelText: 'Months'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter number of Months';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListunpaid[index].descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Description';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _formsListunpaid[index].supportedDocController,
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
          onPressed: () => deleteUnpaidForm(index),
          child: Text('Delete'),
        ),
      ],
    );
  }
}
