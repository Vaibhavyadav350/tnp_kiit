import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/user/home/NewHomePage/Components/MiniCard.dart';

import 'Components/HeroCard.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        HeroCard(
            title: 'Semester\nWise\nReport',
            imgPath: 'assets/vector/Research paper-amico.png',
            height: 180,
            width: 400,
            pos: -160,
            titlepos: 50,
            titleSize: 25,
            textcolor:'37474F',
            hexColorCode: 'E1D4C3'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                miniCard(
                    title: 'Basic Profile',
                    imgPath: 'assets/vector/basicpro.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    bottomPos: -20,
                    imgwidth: 200,
                    hexColorCode: 'D3E3D6'),
                miniCard(
                    title: 'Basic Profile',
                    imgPath: 'assets/vector/Recommendation letter-amico.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: 0,
                    bottomPos: -20,
                    hexColorCode: 'FDBC96'),
              ],
            ),
            Column(
              children: [
                miniCard(
                    title: 'College \nExperience',
                    imgPath: 'assets/vector/boy on graduation-cuate.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: -20,
                    bottomPos: -20,
                    hexColorCode: 'EFC4B9'),
                miniCard(
                    title: 'Basic Profile',
                    imgPath: 'assets/vector/Studying-pana.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    hexColorCode: 'BAC9CE'),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Studying-pana.png',
                height: 180,
                width: 180,
                rightPos: 0,
                hexColorCode: 'FDBC96'),
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Webinar-amico.png',
                height: 180,
                width: 180,
                rightPos: 0,
                hexColorCode: 'DAC2CF'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Research paper-amico.png',
                height: 180,
                width: 180,
                rightPos: 0,
                hexColorCode: 'E1D4C3'),
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Recommendation letter-amico.png',
                height: 180,
                width: 180,
                rightPos: 0,
                hexColorCode: 'BAC9CE'),
          ],
        ),
      ],
    );
  }
}
