import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/school/tenth_achievements.dart';

import '../../../navigation/drawer.dart';
import '../../../theme/utils/text/neo_box.dart';

class TenthGradeInfo extends StatefulWidget {
  const TenthGradeInfo({super.key});

  @override
  _TenthGradeInfoState createState() => _TenthGradeInfoState();
}

class _TenthGradeInfoState extends State<TenthGradeInfo> {
  final _formKey = GlobalKey<FormState>();
  final _yearPassingController = TextEditingController();
  final _rollNumberController = TextEditingController();
  final _cgpaController = TextEditingController();
  final _boardNameController = TextEditingController();
  final _characterCertificateLinkController = TextEditingController();
  final _markSheetLinkController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> years = List.generate(11, (index) => (2015 + index).toString());

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
    _fetchFromFirestore();
  }

  Future<void> _fetchFromFirestore() async {
    if (Firebase.apps.isEmpty) return;
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
    if (data.containsKey('Tenth Grade Data')) {
      Map<String, dynamic> tenthGradeData = data['Tenth Grade Data'];
      _yearPassingController.text = tenthGradeData['10thYearPassing'] ?? '';
      _rollNumberController.text = tenthGradeData['10thRollNumber'] ?? '';
      _cgpaController.text = tenthGradeData['10thCGPA'] ?? '';
      _boardNameController.text = tenthGradeData['10thBoardName'] ?? '';
      _characterCertificateLinkController.text =
          tenthGradeData['10thCharacterCertificateLink'] ?? '';
      _markSheetLinkController.text = tenthGradeData['10thMarkSheetLink'] ?? '';
    }
  }

  void _saveToFirestore() async {
    final tenthGradeData = {
      '10thYearPassing': _yearPassingController.text,
      '10thRollNumber': _rollNumberController.text,
      '10thCGPA': _cgpaController.text,
      '10thBoardName': _boardNameController.text,
      '10thCharacterCertificateLink': _characterCertificateLinkController.text,
      '10thMarkSheetLink': _markSheetLinkController.text,
    };

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'Tenth Grade Data': tenthGradeData,
      },
      SetOptions(merge: true), // Merge with existing data if it exists
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('10th Grade Info Updated!!')),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TenthGradeAchievements()),
      );
    })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save information')),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    _yearPassingController.text = "2015";
    return Scaffold(
      endDrawer: const SideDrawer(),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: padWrap(
            Column(
              children: [
                smallSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/tnpkiit.png",
                      width: 50,
                    ),
                    Text(
                      "Educational Details",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                smallSpacing(),
                Text(
                  "10th/Matriculation Details",
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      smallSpacing(),
                      MatTextField(
                        icon: Icons.numbers,
                        label: "Roll Number",
                        controller: _rollNumberController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),

                      ),
                      MatTextField(
                        label: "CGPA",
                        controller: _cgpaController,icon: Icons.grade,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),

                      ),
                      MatTextField(
                        label: "Board Name",
                        controller: _boardNameController,icon: Icons.border_all
                      ),
                      MatTextField(
                        label: "Character Certificate Link",
                        controller: _characterCertificateLinkController,icon: Icons.library_add_check
                      ),
                      MatTextField(
                        label: "Mark Sheet Link",
                        controller: _markSheetLinkController,icon: Icons.ac_unit
                      ),
                      padWrap(
                        DropdownButtonFormField<String>(
                          dropdownColor: darkHighlight,
                          items: List<String>.generate(
                              11, (index) => (2015 + index).toString())
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _yearPassingController.text = newValue!;
                            });
                          },
                          value: _yearPassingController.text,
                          // Ensure it matches one of the available values
                          decoration: InputDecoration(
                            labelText: "Year of Passing",
                            labelStyle: textAnnotation(context),
                          ),
                        ),
                      ),
                      smallSpacing(),
                      MatTextButton(
                        text: "Save",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveToFirestore();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pad: 16.0,
          ),
        ),
      ),
    );
  }
}