import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiit_connect/user/member/chat/project_card.dart';

import '../../../theme/colors.dart';

class SocialFeed extends StatefulWidget {
  @override
  _SocialFeedState createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: padWrap(
            Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("    TNP Social", style: textTitle(context)),
                  ],
                ),
                smallSpacing(),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('projects').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var projects = snapshot.data!.docs;
                    return Column(
                      children: projects.map((project) {
                        return buildProjectCard(
                          projectName: project['projectName'],
                          projectDescription: project['projectDescription'],
                          imageUrl: project['imageUrl'],
                          tags: List<String>.from(project['tags']),
                          status: project['status'],
                          links: List<String>.from(project['links']),
                          userImage: project['uploaded_by_image'],
                          userEmail:project['uploaded_by']
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}