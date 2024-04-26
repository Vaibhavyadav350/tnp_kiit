import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/user/member/school/twelfth_achievements.dart';



import '../../../navigation/drawer.dart';
import '../../../theme/colors.dart';
import '../../../theme/neo_box.dart';

class TwelfthGradeInfo extends StatefulWidget {
  const TwelfthGradeInfo({super.key});

  @override
  _TwelfthGradeInfoState createState() => _TwelfthGradeInfoState();
}

class _TwelfthGradeInfoState extends State<TwelfthGradeInfo> {
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
    if (data.containsKey('twelfthGradeData')) {
      Map<String, dynamic> twelfthGradeData = data['twelfthGradeData'];
      _yearPassingController.text = twelfthGradeData['12thYearPassing'] ?? '';
      _rollNumberController.text = twelfthGradeData['12thRollNumber'] ?? '';
      _cgpaController.text = twelfthGradeData['12thCGPA'] ?? '';
      _boardNameController.text = twelfthGradeData['12thBoardName'] ?? '';
      _characterCertificateLinkController.text =
          twelfthGradeData['12thCharacterCertificateLink'] ?? '';
      _markSheetLinkController.text = twelfthGradeData['12thMarkSheetLink'] ?? '';
    }
  }

  void _saveToFirestore() async {
    final twelfthGradeData = {
      '12thYearPassing': _yearPassingController.text,
      '12thRollNumber': _rollNumberController.text,
      '12thCGPA': _cgpaController.text,
      '12thBoardName': _boardNameController.text,
      '12thCharacterCertificateLink': _characterCertificateLinkController.text,
      '12thMarkSheetLink': _markSheetLinkController.text,
    };

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'twelfthGradeData': twelfthGradeData,
      },
      SetOptions(merge: true), // Merge with existing data if it exists
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('12th Grade Info Updated!!')),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TwelfthGradeAchievements()),
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
                  "12th/Matriculation Details",
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
                      ),
                      MatTextField(
                        label: "CGPA",
                        controller: _cgpaController,icon: Icons.grade,
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
