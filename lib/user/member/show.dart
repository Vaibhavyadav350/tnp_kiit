import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
// ... [other imports]

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<Map<String, dynamic>> commonSkillDetails = [];

  @override
  void initState() {
    super.initState();
    fetchSkills();
  }




  Future<void> fetchSkills() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (docSnap.exists && docSnap.data() != null) {
      List<dynamic> professionalExperiences = docSnap.get('ProfessionalExperiences') ?? [];
      List<dynamic> competency = docSnap.get('Competency') ?? [];

      Set<String> profSkills = {};
      Map<String, String> compSkillsWithLevel = {};
      Map<String, dynamic> skillDetails = {};

      // Extracting skills from professional experiences
      for (var experience in professionalExperiences) {
        List<String> skills = List<String>.from(experience['Skills'] ?? []);
        for (var skill in skills) {
          skillDetails[skill] = {
            'Role': experience['Role'],
            'Company': experience['Company'],
            'Paid': experience['Paid'],
            'Stipend':experience['Stipend'],
            'SupportedDoc':experience['SupportedDoc'],
            'BankStatement':experience['BankStatement'],
          };
        }
        profSkills.addAll(skills);
      }

      // Extracting skills with levels from competency
      for (var competencyData in competency) {
        List<String> skills = List<String>.from(competencyData['Skills'] ?? []);
        String level = competencyData['level'];
        for (var skill in skills) {
          compSkillsWithLevel[skill] = level;
        }
      }

      // Get common skills with their competency levels
      for (var skill in profSkills) {
        if (compSkillsWithLevel.containsKey(skill)) {
          commonSkillDetails.add({
            'Skill': skill,
            'Competency': compSkillsWithLevel[skill],
            ...skillDetails[skill]
          });
        }
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common Skills with Competency'),
      ),
      body: ListView.builder(
        itemCount: commonSkillDetails.length,
        itemBuilder: (context, index) {
          var details = commonSkillDetails[index];
          return ListTile(
            title: Text(details['Skill']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Competency: ${details['Competency']}'),
                Text('Role: ${details['Role']}'),
                Text('Company: ${details['Company']}'),
                if (details['Paid'] == true) Text('Paid'),
                if (details['Paid'] == true)
                  TextButton(
                  child: Text('Supported Doc '),
                   onPressed: () {
                   //  Navigator.of(context).push(
                     // MaterialPageRoute(
                     //   builder: (context) => PDFViewPage(url: details['SupportedDoc']),
                    // ),
                   // );
                    },
                ),


                if (details['Paid'] == true) ElevatedButton(
                  child: Text('BankStatement '),
                  onPressed: () {
                //     Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => PDFViewPage(url: details['BankStatement']),
                //   ),
                // );
                    },
                ),

              ],
            ),
          );

        },
      ),
    );
  }
}
