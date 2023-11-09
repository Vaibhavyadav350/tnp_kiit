import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/user/member/sem/fifth_sem.dart';

import '../../../drawer/drawer.dart';
import '../../../theme/colors.dart';
import '../../../theme/neo_box.dart';



class FourthSemesterPerformance extends StatefulWidget {
  @override
  _FourthSemesterPerformanceState createState() => _FourthSemesterPerformanceState();
}

class _FourthSemesterPerformanceState extends State<FourthSemesterPerformance> {
  final _formKey = GlobalKey<FormState>();
  final _sgpaController = TextEditingController();
  final _cgpaController = TextEditingController();
  final _markSheetLinkController = TextEditingController();
  final _coCurricularActivitiesController = TextEditingController();
  final _extraCurricularActivitiesController = TextEditingController();
  final _volunteeringActivitiesController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    if (data.containsKey('fourthSemesterPerformance')) {
      Map<String, dynamic> fourthSemesterPerformance = data['fourthSemesterPerformance'];
      _sgpaController.text = fourthSemesterPerformance['sgpa'] ?? '';
      _cgpaController.text = fourthSemesterPerformance['cgpa'] ?? '';
      _markSheetLinkController.text = fourthSemesterPerformance['markSheetLink'] ?? '';
      _coCurricularActivitiesController.text = fourthSemesterPerformance['coCurricularActivities'] ?? '';
      _extraCurricularActivitiesController.text = fourthSemesterPerformance['extraCurricularActivities'] ?? '';
      _volunteeringActivitiesController.text = fourthSemesterPerformance['volunteeringActivities'] ?? '';
    }
  }

  void _saveToFirestore() async {
    final fourthSemesterPerformance = {
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
        'fourthSemesterPerformance': fourthSemesterPerformance,
      },
      SetOptions(merge: true), // Merge with existing data if it exists
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('4th Semester Performance Updated!!')),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FifthSemesterPerformance()),
      );
    })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save information')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SideDrawer(),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                  "4th Semester Performance",
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
                      ),
                      MatTextField(
                        label: "CGPA",
                        controller: _cgpaController,
                        icon: Icons.equalizer, // Icon for CGPA
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
