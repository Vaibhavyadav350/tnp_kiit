import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../NewHomePage/NewHomePage.dart';

class AddProjectFeed extends StatelessWidget {
  const AddProjectFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFFFFD700), // Gold
                  Color(0xFFFFA500)]),
                    ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: -40,
                      bottom: -30,
                      child: Image.asset(
                          fit: BoxFit.fitWidth,
                          width: 300,
                          "assets/vector/Image folder-cuate.png"),
                    ),
                    Positioned(
                      right: 10,
                      top: 110,
                      child: Text(
                        "Post Your\nProjects & \nCertificates",
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
          ],
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
