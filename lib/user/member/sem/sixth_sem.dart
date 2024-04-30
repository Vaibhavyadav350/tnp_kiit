import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/user/member/sem/seventh_sem.dart';

import '../../../navigation/drawer.dart';
import '../../../theme/colors.dart';
import '../../../theme/utils/text/neo_box.dart';



class SixthSemesterPerformance extends StatefulWidget {
  const SixthSemesterPerformance({super.key});

  @override
  _SixthSemesterPerformanceState createState() => _SixthSemesterPerformanceState();
}

class _SixthSemesterPerformanceState extends State<SixthSemesterPerformance> {
  final _formKey = GlobalKey<FormState>();
  final _sgpaController = TextEditingController();
  final _cgpaController = TextEditingController();
  final _markSheetLinkController = TextEditingController();
  final _coCurricularActivitiesController = TextEditingController();
  final _extraCurricularActivitiesController = TextEditingController();
  final _volunteeringActivitiesController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    if (data.containsKey('sixSemesterPerformance')) {
      Map<String, dynamic> sixSemesterPerformance = data['sixSemesterPerformance'];
      _sgpaController.text = sixSemesterPerformance['sgpa'] ?? '';
      _cgpaController.text = sixSemesterPerformance['cgpa'] ?? '';
      _markSheetLinkController.text = sixSemesterPerformance['markSheetLink'] ?? '';
      _coCurricularActivitiesController.text = sixSemesterPerformance['coCurricularActivities'] ?? '';
      _extraCurricularActivitiesController.text = sixSemesterPerformance['extraCurricularActivities'] ?? '';
      _volunteeringActivitiesController.text = sixSemesterPerformance['volunteeringActivities'] ?? '';
    }
  }

  void _saveToFirestore() async {
    final sixSemesterPerformance = {
      'sgpa': _sgpaController.text,
      'cgpa': _cgpaController.text,
      'markSheetLink': _markSheetLinkController.text,
      'coCurricularActivities': _coCurricularActivitiesController.text,
      'extraCurricularActivities': _extraCurricularActivitiesController.text,
      'volunteeringActivities': _volunteeringActivitiesController.text,
    };

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'sixSemesterPerformance': sixSemesterPerformance,
      },
      SetOptions(merge: true), // Merge with existing data if it exists
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('6th Semester Performance Updated!!')),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>const SeventhSemesterPerformance()),
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
                  "6th Semester Performance",
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
                        label: "SGPA",
                        controller: _sgpaController,
                        icon: Icons.equalizer, // Icon for SGPA
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),

                      ),
                      MatTextField(
                        label: "CGPA",
                        controller: _cgpaController,
                        icon: Icons.equalizer, // Icon for CGPA
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),

                      ),
                      MatTextField(
                        label: "Marksheet Link",
                        controller: _markSheetLinkController,
                        icon: Icons.link, // Icon for the link
                      ),
                      MatTextField(
                        label: "Co-Curricular Activities",
                        controller: _coCurricularActivitiesController,
                        icon: Icons.library_books, // Icon for library books
                      ),
                      MatTextField(
                        label: "Extra-Curricular Activities",
                        controller: _extraCurricularActivitiesController,
                        icon: Icons.star, // Icon for star or achievement
                      ),
                      MatTextField(
                        label: "Volunteering Activities",
                        controller: _volunteeringActivitiesController,
                        icon: Icons.group, // Icon for group or community
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
