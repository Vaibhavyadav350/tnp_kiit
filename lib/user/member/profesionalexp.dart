import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/user/member/projects.dart';
import '../../drawer/drawer.dart';
import '../../theme/neo_box.dart';
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
  String level = 'Basic';
  var items = [
    'Basic',
    'Intermediate',
    'Experienced',
  ];
  String domains = 'JavaScript';
  var domainsSkill = [
    // Programming Languages
    'JavaScript',
    'Python',
    'Java',
    'C#',
    'C++',
    'Swift',
    'Kotlin',
    'Ruby',
    'PHP',
    'TypeScript',

    // Frameworks/Libraries
    'React.js',
    'Angular',
    'Vue.js',
    'Node.js',
    'Express.js',
    'Django',
    'Flask',
    'Spring Boot',
    '.NET Core',

    // Databases
    'SQL',
    'NoSQL',
    'ORM',

    // Tools
    'Git & GitHub',
    'Docker',
    'Kubernetes',
    'Jenkins',
    'Webpack',
    'Babel',

    // Web Technologies
    'HTML',
    'CSS',
    'Bootstrap',
    'SASS/SCSS',
    'GraphQL',
    'REST APIs',

    // Mobile Development
    'iOS Development',
    'Android Development',
    'React Native',
    'Flutter',

    // Cloud Services
    'Amazon Web Services',
    'Google Cloud Platform',
    'Microsoft Azure',
    'Firebase',

    // DevOps & Continuous Integration/Continuous Deployment (CI/CD)
    'DevOps',
    'Continuous Integration',
    'Continuous Deployment',

    // Testing
    'Unit Testing',
    'Integration Testing',
    'End-to-End Testing',
    'Jest',
    'Mocha',
    'JUnit',
  ];

  List<String> selectedSkills = [];
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
      formFields.level = experience['Competency'] ?? '';
      formFields.showStipendField = experience['Paid'] ?? '';
      formFields.selectedSkills = List<String>.from(experience['Skills'] ?? []);
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
        'BankStatement': formFields.bankStatement.text,
        'Competency': formFields.level,
        'Skills': formFields.selectedSkills,
        'Paid': formFields.showStipendField,
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PersonalProject()),
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
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: const Text('Professional Experience'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: addForm,
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.save),
      //       onPressed: () {
      //         if (_formKey.currentState!.validate()) {
      //           saveToFirestore();
      //         }
      //       },
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveToFirestore();
          }
        },
        label: const Text('Proceed',style: TextStyle(color: Colors.green),),
        icon: const Icon(Icons.keyboard_double_arrow_right,color: Colors.green),
        backgroundColor: Colors.grey[300],
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
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
                        "Professional Experience",
                        style: TextStyle(letterSpacing: 2),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: NeoBox(
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: addForm,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
      ),
    );
  }

  Widget buildForm(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: NeoBox(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: NeoBox(
                  child: Center(
                    child: DropdownButton<String>(
                      // Initial Value
                      value: _formsList[index].level,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: _formsList[index].items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),

                      // After selecting the desired option, it will change button value to selected value
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _formsList[index].level = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: PopupMenuButton<String>(
                  child: ListTile(
                    title: Text('Select Skills'),
                    trailing: Icon(Icons.arrow_drop_down),
                  ),
                  onSelected: (value) {
                    setState(() {
                      if (_formsList[index].selectedSkills.contains(value)) {
                        _formsList[index].selectedSkills.remove(value);
                      } else {
                        _formsList[index].selectedSkills.add(value);
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return _formsList[index].domainsSkill.map((String skillItem) {
                      return PopupMenuItem<String>(
                        value: skillItem,
                        child: CheckboxListTile(
                          title: Text(skillItem),
                          value: _formsList[index].selectedSkills.contains(skillItem),
                          onChanged: (bool? value) {
                            Navigator.of(context).pop(); // close the menu
                            if (value != null) {
                              if (value) {
                                _formsList[index].selectedSkills.add(skillItem);
                              } else {
                                _formsList[index].selectedSkills.remove(skillItem);
                              }
                              setState(() {});
                            }
                          },
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: TextFormField(
                  controller: _formsList[index].roleController,
                  decoration: InputDecoration(labelText: 'Role', border: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Role Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: TextFormField(controller: _formsList[index].companyController,
                  decoration: const InputDecoration(labelText: 'Company', border: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Company Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: TextFormField(controller: _formsList[index].monthController,
                  decoration: const InputDecoration(labelText: 'Months', border: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter number of Months';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: TextFormField(
                  controller: _formsList[index].descriptionController,
                  decoration: InputDecoration(labelText: 'Description', border: InputBorder.none),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: GestureDetector(
                  onTap: () async {
                    String? url = await pickAndUploadSupportedDoc();
                    if (url != null) {
                      _formsList[index].supportedDocController.text = url;
                      setState(() {}); // to refresh the UI
                    }
                  },
                  child: Row(
                    children: [
                      const Text('Select Supported Document'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              NeoBox(
                child: CheckboxListTile(

                  title: const Text('Paid'),
                  value: _formsList[index].showStipendField,
                  onChanged: (value) {setState(() {
                      _formsList[index].showStipendField = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20,),
              if (_formsList[index].showStipendField) ...[
                NeoBox(
                  child: TextFormField(
                    controller: _formsList[index].stipendController,
                    decoration: const InputDecoration(labelText: 'Stipend', border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Stipend Amount';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                NeoBox(
                  child: GestureDetector(
                    onTap: () async {
                      String? url = await pickAndUploadBankStatement();
                      if (url != null) {
                        _formsList[index].bankStatement.text = url;
                        setState(() {}); // to refresh the UI
                      }
                    },
                    child: Row(
                      children: [
                        Text('Select Bank Statement'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
              NeoBox(
                child: GestureDetector(
                  onTap: () => deleteForm(index),
                  child: const Text('  Delete  ',style: TextStyle(fontSize: 17,color: Colors.redAccent),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
