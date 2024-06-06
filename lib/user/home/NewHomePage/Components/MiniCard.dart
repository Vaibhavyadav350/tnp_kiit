import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget miniCard({
  double bottomPos = -40,
  required String title,
  required String imgPath,
  required double height,
  required double width,
  required double rightPos,
  double imgwidth = 180,
  required String hexColorCode,
}) {
  Color backgroundColor = Color(int.parse('0xFF$hexColorCode'));
  Color textColor = Color(int.parse('0xFF240750'));

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 20,
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0,
                    color: textColor,
                  ),
                ),
              ),
              Positioned(
                bottom: bottomPos,
                right: rightPos,
                child: Image.asset(
                  imgPath,
                  width: imgwidth,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
