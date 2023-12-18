// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
class TiledButton extends StatelessWidget {

  final String iconImagePath;
  final String buttonText;


  const TiledButton({
    super.key, required this.iconImagePath, required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
                decoration: BoxDecoration(
                    // color: Colors.grey.shade300,
                    // color: Color.fromARGB(255, 255, 238, 207),
                    color: darkBackground,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.white60,
                        // blurRadius: 4,
                        // spreadRadius: 2,
                      )
                    ]),
                padding: EdgeInsets.all(10),
                height: 90,
                child: Center(
                  child: Image.asset(iconImagePath),
                )),
          ),
          SizedBox(height: 10),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                // fontWeight: FontWeight.bold
                ),
          ),
        ]
    );
  }
}
