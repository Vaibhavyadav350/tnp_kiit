import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/user/member/school/twelth_ac.dart';


import '../../../navigation/drawer.dart';
import '../../../theme/colors.dart';
import '../../../theme/neo_box.dart';

class TenthGradeAchievements extends StatefulWidget {
  @override
  _TenthGradeAchievementsState createState() => _TenthGradeAchievementsState();
}

class _TenthGradeAchievementsState extends State<TenthGradeAchievements> {
  final _formKey = GlobalKey<FormState>();
  final _certificateLinkController = TextEditingController();
  final _curricularActivitiesController = TextEditingController();
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
    if (data.containsKey('tenthGradeAchievements')) {
      Map<String, dynamic> tenthGradeAchievements = data['tenthGradeAchievements'];
      _certificateLinkController.text = tenthGradeAchievements['certificateLink'] ?? '';
      _curricularActivitiesController.text = tenthGradeAchievements['curricularActivities'] ?? '';
      _coCurricularActivitiesController.text = tenthGradeAchievements['coCurricularActivities'] ?? '';
      _extraCurricularActivitiesController.text = tenthGradeAchievements['extraCurricularActivities'] ?? '';
      _volunteeringActivitiesController.text = tenthGradeAchievements['volunteeringActivities'] ?? '';
    }
  }

  void _saveToFirestore() async {
    final tenthGradeAchievements = {
      'certificateLink': _certificateLinkController.text,
      'curricularActivities': _curricularActivitiesController.text,
      'coCurricularActivities': _coCurricularActivitiesController.text,
      'extraCurricularActivities': _extraCurricularActivitiesController.text,
      'volunteeringActivities': _volunteeringActivitiesController.text,
    };

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'tenthGradeAchievements': tenthGradeAchievements,
      },
      SetOptions(merge: true), // Merge with existing data if it exists
    )
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('10th Grade Achievements Updated!!')),
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TwelfthGradeInfo()),
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
                      "Achievements",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      smallSpacing(),
                      MatTextField(
                        label: "Certificate Link",
                        controller: _certificateLinkController,
                        icon: Icons.link, // Icon for the link
                      ),
                      MatTextField(
                        label: "Curricular Activities",
                        controller: _curricularActivitiesController,
                        icon: Icons.sports, // Icon for sports activities
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
