import 'dart:ui';

import 'package:flutter/material.dart';

class HaveThisCard extends StatelessWidget {
  final double height;
  final double width;
  final DecorationImage image;
  final double curvature;
  final Gradient gradient;
  final theChild;

  const HaveThisCard(
      {super.key,
      required this.image,
      required this.curvature,
      required this.height,
      required this.width,
      this.theChild,
      required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(curvature),
      child: Container(
          width: width,
          height: height,
          color: Colors.transparent,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: new AssetImage(
          //             "assets/images/backgrounds/01_home_background.png"),
          //         fit: BoxFit.cover)),
          child: Stack(children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(curvature),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: gradient,
                  image: image),
            ),
            Container(decoration: const BoxDecoration(gradient: closer)),
            Container(alignment: Alignment.bottomLeft, padding: const EdgeInsets.all(20.0), child: theChild)
          ])),
    );
  }
}

const Gradient closer = LinearGradient(
    begin: Alignment.center,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(0, 0, 0, 0),
      Color.fromARGB(255, 0, 0, 0),
    ]);
