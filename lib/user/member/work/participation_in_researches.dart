import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/neo_box.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/newscreens/home.dart';

class FormFields {
  var referenceTypes = [
    'Bill',
    'Book',
    'Book Section',
    'Case',
    'Computer Program',
    'Conference Proceedings',
    'Encyclopedia Article',
    'Film',
    'Hearing',
    'Journal Article',
    'Magazine Article',
    'Newspaper Article',
    'Patent',
    'Report',
    'Statute',
    'Television Broadcast',
    'Thesis',
    'Unspecified',
    'Web Page',
    'Working Paper'
  ];
  String referenceType = 'Journal Article';

  TextEditingController titleController = TextEditingController();

  // Used TextEditingController instead of String to experiment with dynamic and i-mutable lists
  List<TextEditingController> authorNameControllers = [TextEditingController()];

  TextEditingController abstractController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController identifierController = TextEditingController();
}

class AcademicAchievements extends StatefulWidget {
  @override
  _AcademicAchievementsState createState() => _AcademicAchievementsState();
}

class _AcademicAchievementsState extends State<AcademicAchievements> {
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

  void addNewAuthor(int index) {
    _formsList[index].authorNameControllers.add(TextEditingController());
    setState(() {});
  }

  void removeLastAuthor(int index) {
    if (_formsList[index].authorNameControllers.length == 1) return;
    _formsList[index].authorNameControllers.removeLast();
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

    List<dynamic> data = docSnap.get('AcademicAchievements') as List<dynamic>;
    _formsList = data.map((item) {
      Map<String, dynamic> experience = item as Map<String, dynamic>;
      FormFields formFields = FormFields();
      formFields.referenceType =
          experience['ReferenceType'] ?? formFields.referenceType;
      formFields.titleController.value = experience['Title'] ?? '';
      formFields.authorNameControllers =
          List<String>.from(experience['AuthorNames'] ?? [])
              .map((e) => TextEditingController(text: e))
              .toList();
      formFields.abstractController.value = experience['Abstract'] ?? '';
      formFields.yearController.value = experience['Year'] ?? '';
      formFields.urlController.value = experience['URL'] ?? '';
      formFields.identifierController.value = experience['Identifier'] ?? '';
      return formFields;
    }).toList();

    setState(() {});
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> proexp = [];

    for (int i = 0; i < _formsList.length; i++) {
      final FormFields formFields = _formsList[i];
      final achievements = {
        'ReferenceType': formFields.referenceType,
        'Title': formFields.titleController.value,
        'AuthorNames':
            formFields.authorNameControllers.map((e) => e.value).toList(),
        'Abstract': formFields.abstractController.value,
        'Year': formFields.yearController.value,
        'URL': formFields.urlController.value,
        'Identifier': formFields.identifierController.value,
      };
      proexp.add(achievements);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'AcademicAchievements': proexp}, SetOptions(merge: true)).then(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveToFirestore();
          }
        },
        label: Text(
          'Proceed',
          style: textAnnotation(context),
        ),
        icon:
            const Icon(Icons.keyboard_double_arrow_right, color: Colors.black),
        backgroundColor: greenHighlight,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      // Handle back button pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewHomePage(),
                        ),
                      );
                    },
                  ),
                ),
                const Text(
                  "Academic Achievements",
                  style: TextStyle(color: Colors.white, letterSpacing: 2),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    icon:
                        Icon(Icons.add, color: Theme.of(context).primaryColor),
                    onPressed: addForm,
                  ),
                )
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
          )
        ])),
      )),
    );
  }

  Widget buildForm(int index) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(children: [
          padWrap(SizedBox(
              width: double.infinity,
              child: boxWrap(
                  Center(
                      child: DropdownButton<String>(
                          value: _formsList[index].referenceType,
                          style: textAnnotation(context),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: theme.primaryColor),
                          items: _formsList[index]
                              .referenceTypes
                              .map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _formsList[index].referenceType = newValue;
                              });
                            }
                          })),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0)))),
          SizedBox(height: 20),
          padWrap(Column(children: [
            SizedBox(
                width: double.infinity,
                child:
                    Text("Add Author Names", style: textAnnotation(context))),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: boxWrap(Column(
                children: _formsList[index]
                    .authorNameControllers
                    .map((e) => TextField(
                          controller: e,
                          style: textAnnotation(context),
                        ))
                    .toList(),
              )),
            ),
            SizedBox(height: 20),
            boxWrap(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => addNewAuthor(index),
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () => removeLastAuthor(index),
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(context).primaryColor,
                    )),
              ],
            ))
          ])),
          SizedBox(height: 20),
          MatTextField(
              label: "Title", controller: _formsList[index].titleController),
          SizedBox(height: 20),
          MatTextField(
              label: "Year of publication",
              controller: _formsList[index].yearController),
          SizedBox(height: 20),
          MatTextField(
              label: "URL (Journal or PDF)",
              controller: _formsList[index].urlController),
          SizedBox(height: 20),
          MatTextField(
              label: "Identifier (DOI/ArXivID/ISBN...)",
              controller: _formsList[index].identifierController),
          SizedBox(height: 20),
          padWrap(boxWrap(GestureDetector(
            onTap: () => deleteForm(index),
            child: const Text(
              '  Delete  ',
              style: TextStyle(fontSize: 17, color: Colors.redAccent),
            ),
          )))
        ]),
      ),
    );
  }
}
