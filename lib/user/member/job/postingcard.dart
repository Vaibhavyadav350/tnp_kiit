import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class JobListingCard extends StatefulWidget {
  final String jobTitle;
  final String jobDescription;
  final String? companyName;
  final String? companyCulture;
  final String? location;
  final String? applicationDeadline;
  final String? contactInformation_Email;
  final String? contactInformation_Phone;
  final String? salary;
  final String? duration;
  final String? educationRequirements;
  final String? experienceLevel;
  final String? internshipType;
  final String? howToApply;
  final String? skills;
  final String? docid;

  const JobListingCard({super.key, 
    required this.jobTitle,
    required this.jobDescription,
    this.companyName,
    this.companyCulture,
    this.location,
    this.applicationDeadline,
    this.contactInformation_Email,
    this.contactInformation_Phone,
    this.salary,
    this.duration,
    this.educationRequirements,
    this.experienceLevel,
    this.internshipType,
    this.howToApply,
    this.skills,
    this.docid,
  });

  @override
  _JobListingCardState createState() => _JobListingCardState();
}

class _JobListingCardState extends State<JobListingCard> {
  bool isExpanded = false;
  bool isApplied = false; // Track if the user has already applied
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    checkAppliedStatus();
  }



  Future<void> checkAppliedStatus() async {
    String studentEmail = FirebaseAuth.instance.currentUser!.email!;
    var snapshot = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    var appliedJobs = snapshot.data()?['AppliedTo'];
    if (appliedJobs != null) {

      for (var job in appliedJobs) {
        if (job['id'] == widget.docid && job['status'] == 'Applied') {
          setState(() {
            isApplied = true;
          });
          break;
        }
      }
    }
  }




  @override
  Widget build(BuildContext context) {


    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.jobTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          "Company: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.companyName!,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: const Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                // Conditionally show Apply Now button
                if (isApplied)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Applied",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                if (!isApplied)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                    ),
                    onPressed: () async {
                      String studentEmail =
                          FirebaseAuth.instance.currentUser!.email!;
                      FirebaseFirestore.instance
                          .collection('job_postings')
                          .doc(widget.docid)
                          .update({
                        'AppliedBy': FieldValue.arrayUnion([studentEmail])
                      });
                      await FirebaseFirestore.instance
                          .collection('StudentInfo')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .update({
                        'AppliedTo': FieldValue.arrayUnion([
                          {
                            'id': widget.docid,
                            'company': widget.companyName,
                            'status': 'Applied'
                          }
                        ])
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Oh Hey!!',
                            message:
                                'You Have Successfully applied to ${widget.companyName} for ${widget.jobTitle}',
                            contentType: ContentType.success,
                          ),
                        ),
                      );
                      setState(() {
                        isApplied = true;
                      });
                    },
                    child:
                        const Text("Apply Now", style: TextStyle(color: Colors.blue)),
                  ),
              ],
            ),
            if (isExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Job Description', widget.jobDescription),
                  // _buildDetailRow('Company Culture', widget.companyCulture),
                  _buildDetailRow('Location', widget.location),
                  _buildDetailRow(
                      'Application Deadline', widget.applicationDeadline),
                  _buildDetailRow('Email', widget.contactInformation_Email),
                  _buildDetailRow('Phone', widget.contactInformation_Phone),
                  _buildDetailRow('Salary', widget.salary),
                  _buildDetailRow('Duration', widget.duration),
                  _buildDetailRow(
                      'Education Requirements', widget.educationRequirements),
                  _buildDetailRow('Experience Level', widget.experienceLevel),
                  _buildDetailRow('Internship Type', widget.internshipType),
                  _buildDetailRow('How to Apply', widget.howToApply),
                  _buildDetailRow('Skills', widget.skills),
                  if (widget.companyCulture != null) // Check if company culture URL is available
                    InkWell(
                      onTap: () async {
                        final url = widget.companyCulture!;
                        print('Opening URL in browser: $url');
                        await launch(url, forceSafariVC: false, forceWebView: false);
                      },
                      child: const ElevatedButton(
                        onPressed: null,
                        child: Text(
                          "Download JD",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    )

                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return value != null && value.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label: ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
