import 'package:flutter/material.dart';

Widget HeroCard({
  required String title,
  required double titleSize,
  required double titlepos,
  required String imgPath,
  required double height,
  required double width,
  required double pos,
  required String hexColorCode,
  required String textcolor,
}) {
  Color backgroundColor = Color(int.parse('0xFF$hexColorCode'));
  Color textColor = Color(int.parse('0xFF$textcolor'));

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 8.0,
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
                top: titlepos,
                left: 20,
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                right: pos,
                child: Image.asset(
                  imgPath,
                  width: width,
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
