import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../theme/colors.dart';
import '../../member/chat/project_card.dart';

class KoncatSocial extends StatelessWidget {
  const KoncatSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
              gradient:
              LinearGradient(colors: [Color(0xFFe0d2b2), Color(0xFFffbaa8)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.pink, Colors.red]),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        bottom: -10,
                        child: Image.asset(
                            fit: BoxFit.fitWidth,
                            width: 260,
                            "assets/vector/FOMO-amico.png"),
                      ),
                      Positioned(
                        right: 10,
                        top: 110,
                        child: Text(
                          "KONCAT \nSOCIAL",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 22.0,
                            color: Colors.grey.shade100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('projects').orderBy('uplaodTime', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var projects = snapshot.data!.docs;
                  return Column(
                    children: projects.map((project) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: buildProjectCard(
                            projectName: project['projectName'],
                            projectDescription: project['projectDescription'],
                            imageUrl: project['imageUrl'],
                            tags: List<String>.from(project['tags']),
                            status: project['status'],
                            link: project['link'],
                            userImage: project['uploaded_by_image'],
                            userEmail:project['uploaded_by']
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              smallSpacing(),smallSpacing(),

            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
