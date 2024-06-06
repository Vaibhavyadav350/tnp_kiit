// Main big card top centre
// - Semester Grade Report
// - 10th 12th and aachievements
// - 
import 'package:flutter/material.dart';

Widget HeroCard({
  required String title,
  required double titleSize,
  required double titlepos,
  required String imgPath,
  required double height,
  required double width,
  required double pos,
  required String hexColorCode, required String textcolor, // optional background color
}) {

  Color backgroundColor = Color(int.parse('0xFF$hexColorCode'));
  Color TextColor = Color(int.parse('0xFF$textcolor'));

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          if (backgroundColor != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: backgroundColor,
                ),
              ),
            ),
          Positioned(
            top: titlepos,
            left: 20,
            child: Text(
              title,
              style: TextStyle(
                color: TextColor,
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(

            bottom: -40,
            right: pos,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imgPath,
                // Adjust the image height as needed
                width: width, // Ensure the image takes the full width of the container
                fit: BoxFit.cover, // Ensure the image covers the entire space without distortion
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
