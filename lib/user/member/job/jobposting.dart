
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/job/postingcard.dart';

class JobPostingFetch extends StatelessWidget {
  const JobPostingFetch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkShadow,
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('job_postings').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No data available');
            }
            var jobinfos = snapshot.data!.docs;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("     Opportunities ", style: textTitle(context)),
                      SizedBox(
                        height: 60,

                        child:IconButton(
                          icon: Icon(FluentIcons.filter_32_regular,color: Colors.white,),
                          onPressed:(){},

                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: jobinfos.map((jobinfo) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: JobListingCard(
                          jobTitle: jobinfo['jobTitle'],
                          jobDescription: jobinfo['jobDescription'],
                          companyName: jobinfo['companyName'],
                          companyCulture: jobinfo['companyCulture'],
                          location: jobinfo['location'],
                          applicationDeadline: jobinfo['applicationDeadline'],
                          contactInformation_Email:
                              jobinfo['contactInformation_Email'],
                          contactInformation_Phone:
                              jobinfo['contactInformation_Phone'],
                          salary: jobinfo['salary'],
                          duration: jobinfo['duration'],
                          educationRequirements:
                              jobinfo['educationRequirements'],
                          experienceLevel: jobinfo['experienceLevel'],
                          internshipType: jobinfo['internshipType'],
                          howToApply: jobinfo['howToApply'],
                          skills: jobinfo['skills'],
                          docid: jobinfo.id,
                          // imageUrl: jobinfo['imageUrl'],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
