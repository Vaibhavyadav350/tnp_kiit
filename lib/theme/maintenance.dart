import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
Widget Maintenance(){
  return Column(
    children: [
      Container(height: 100,),
      Image.asset("assets/vector/Phone maintenance-amico.png"),
      Text(
        "Page on Maintenance",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 22.0,
          color: Colors.purple,
        ),
      ),
    ],
  );
}
