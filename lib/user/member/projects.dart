import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/user/member/publiclinks.dart';
import '../../drawer/drawer.dart';
import '../../theme/neo_box.dart';

class FormFields {
  TextEditingController roleController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController DemoLinkController = TextEditingController();
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

class PersonalProject extends StatefulWidget {
  @override
  _PersonalProjectState createState() => _PersonalProjectState();
}

class _PersonalProjectState extends State<PersonalProject> {
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

    List<dynamic> data = docSnap.get('PersonalProjects') as List<dynamic>;
    _formsList = data.map((item) {
      Map<String, dynamic> experience = item as Map<String, dynamic>;
      FormFields formFields = FormFields();
      formFields.roleController.text = experience['Project Name'] ?? '';
      formFields.selectedSkills = List<String>.from(experience['Skills'] ?? []);
      formFields.levelController.text = experience['level'] ?? '';
      formFields.githubController.text = experience['Github Link'] ?? '';
      formFields.descriptionController.text = experience['Description'] ?? '';
      formFields.DemoLinkController.text = experience['DemoLink'] ?? '';
      return formFields;
    }).toList();

    setState(() {});
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> personalProjects = [];

    for (int i = 0; i < _formsList.length; i++) {
      final FormFields formFields = _formsList[i];
      final Projectss = {
        'Project Name': formFields.roleController.text,
        'Skills': formFields.selectedSkills,
        'DemoLink': formFields.DemoLinkController.text,
        'Description': formFields.descriptionController.text,
        'level': formFields.levelController.text,
        'Github Link': formFields.githubController.text,
      };

      personalProjects.add(Projectss);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'PersonalProjects': personalProjects},
            SetOptions(merge: true)).then((documentRef) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Info Updated!!')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PublicProfile()),
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
        title: const Text('Personal Projects'),
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
        TextFormField(
          controller: _formsList[index].roleController,
          decoration: InputDecoration(labelText: 'Project Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Project Name Name';
            }
            return null;
          },
        ),

        DropdownButtonFormField<String>(
          value: _formsList[index].levelController.text.isEmpty
              ? null
              : _formsList[index].levelController.text,
          decoration: InputDecoration(
            labelText: 'Level',
          ),
          items:
              <String>['Basic', 'Intermediate', 'Advanced'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _formsList[index].levelController.text = newValue!;
            });
          },
        ),

        // TextFormField(
        //   controller: _formsList[index].levelController,
        //   decoration: const InputDecoration(labelText: 'Level'),
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Enter Level Amount';
        //     }
        //     return null;
        //   },
        // ),
        TextFormField(
          controller: _formsList[index].githubController,
          decoration: const InputDecoration(labelText: 'Github Link'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Github Link';
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
          controller: _formsList[index].DemoLinkController,
          decoration: const InputDecoration(labelText: 'Demo Links'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Demo Links';
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
