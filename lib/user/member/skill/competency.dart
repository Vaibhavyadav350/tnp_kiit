import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import '../../../drawer/drawer.dart';
import '../../../theme/neo_box.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormFields {
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

class Competency extends StatefulWidget {
  @override
  _CompetencyState createState() => _CompetencyState();
}

class _CompetencyState extends State<Competency> {
  final _formKey = GlobalKey<FormState>();

  List<FormFields> _formsList = [];

  void addForm() {
    if (_formsList.length < 3) {
      _formsList.add(FormFields());
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can add up to 3 forms only!')),
      );
    }
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

    if (docSnap.exists && docSnap.data() != null) {
      List<dynamic> data = docSnap.get('Competency') ?? [];
      _formsList = data.map((item) {
        Map<String, dynamic> experience = item as Map<String, dynamic>;
        FormFields formFields = FormFields();

        formFields.level = experience['level'] ?? 'Basic';
        formFields.selectedSkills = List<String>.from(experience['Skills'] ?? []);
        return formFields;
      }).toList();

      setState(() {});
    }
  }






  void saveToFirestore() async {
    List<Map<String, dynamic>> proexp = [];

    for (int i = 0; i < _formsList.length; i++) {
      final FormFields formFields = _formsList[i];
      final CollegeExp = {
        'level': formFields.level,
        'Skills': formFields.selectedSkills,

      };
      proexp.add(CollegeExp);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'Competency': proexp}, SetOptions(merge: true)).then(
            (documentRef) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Info Updated!!')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProfessionalExperience()),
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
                        "Competency",
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
              onSelected: (value) {}, // No changes here anymore.
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
                            if (_formsList[index].selectedSkills.length < 5) {
                              _formsList[index].selectedSkills.add(skillItem);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('You can select up to 5 skills only!')),
                              );
                            }
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
            Wrap(
              spacing: 8.0, // gap between adjacent containers
              runSpacing: 4.0, // gap between lines
              children: _formsList[index].selectedSkills.map((skill) {
                return NeoBox(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(skill),
                ));
              }).toList(),
            ),

            SizedBox(height: 20,),

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
