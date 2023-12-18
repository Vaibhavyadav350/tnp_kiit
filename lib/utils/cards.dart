import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';

class HaveThisCard extends StatelessWidget {
  final double height;
  final double width;
  final String imgPath;
  final double curvature;
  final LinearGradient gradient;
  final theChild;

  const HaveThisCard(
      {super.key,
      this.imgPath = "",
      required this.curvature,
      required this.height,
      required this.width,
      this.theChild, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(curvature),
      child: Container(
          width: width,
          height: height,
          color: Colors.transparent,
          child: Stack(children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(curvature),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: gradient
              ),
            ),
            Container(child: theChild)
          ])),
    );
  }
}
