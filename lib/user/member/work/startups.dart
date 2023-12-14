import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/neo_box.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/newscreens/home.dart';

class FormFields {
  TextEditingController nameController = TextEditingController();
  List<TextEditingController> founderNameControllers = [
    TextEditingController()
  ];
  TextEditingController inceptionDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController uspController = TextEditingController();
  TextEditingController revenueModelController = TextEditingController();
}

class StartupInformation extends StatefulWidget {
  @override
  _StartupInformationState createState() => _StartupInformationState();
}

class _StartupInformationState extends State<StartupInformation> {
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
    _formsList[index].founderNameControllers.add(TextEditingController());
    setState(() {});
  }

  void removeLastAuthor(int index) {
    if (_formsList[index].founderNameControllers.length == 1) return;
    _formsList[index].founderNameControllers.removeLast();
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

    List<dynamic> data = docSnap.get('StartupInformation') as List<dynamic>;
    _formsList = data.map((item) {
      Map<String, dynamic> experience = item as Map<String, dynamic>;
      FormFields formFields = FormFields();
      formFields.nameController.value = experience['Name'] ?? '';
      formFields.founderNameControllers =
          List<String>.from(experience['FounderNames'] ?? [])
              .map((e) => TextEditingController(text: e))
              .toList();
      formFields.inceptionDateController.value =
          experience['InceptionDate'] ?? '';
      formFields.descriptionController.value = experience['Description'] ?? '';
      formFields.industryController.value = experience['Industry'] ?? '';
      formFields.uspController.value = experience['USP'] ?? '';
      formFields.revenueModelController.value =
          experience['RevenueModel'] ?? '';
      return formFields;
    }).toList();

    setState(() {});
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> proexp = [];

    for (int i = 0; i < _formsList.length; i++) {
      final FormFields formFields = _formsList[i];
      final achievements = {
        'Name': formFields.nameController.text,
        'FounderNames':
            formFields.founderNameControllers.map((e) => e.value).toList(),
        'InceptionDate': formFields.inceptionDateController.value,
        'Description': formFields.descriptionController.value,
        'Industry': formFields.industryController.value,
        'USP': formFields.uspController.value,
        'RevenueModel': formFields.revenueModelController.value,
      };
      proexp.add(achievements);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'StartupInformation': proexp}, SetOptions(merge: true)).then(
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
                  "Startups",
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
          MatTextField(
              label: "Startup Name",
              controller: _formsList[index].nameController),
          SizedBox(height: 20),
          padWrap(Column(children: [
            SizedBox(
                width: double.infinity,
                child:
                    Text("Add Founder Names", style: textAnnotation(context))),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: boxWrap(Column(
                children: _formsList[index]
                    .founderNameControllers
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
              label: "Inception Date",
              controller: _formsList[index].inceptionDateController),
          SizedBox(height: 20),
          MatTextField(
            label: "Description",
            controller: _formsList[index].descriptionController,
            maxLines: 3,
          ),
          SizedBox(height: 20),
          MatTextField(
              label: "Industry",
              controller: _formsList[index].industryController),
          SizedBox(height: 20),
          MatTextField(
              label: "Unique Selling Point",
              controller: _formsList[index].uspController),
          SizedBox(height: 20),
          MatTextField(
              label: "Revenue Model",
              controller: _formsList[index].revenueModelController),
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
