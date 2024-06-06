import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/user/home/NewHomePage/Components/MiniCard.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Achievement-amico.png',
                height: 180,
                width: 180,
                pos: 20,
                hexColorCode: 'D3E3D6'),
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Studying-amico.png',
                height: 180,
                width: 180,
                pos: -40,
                hexColorCode: 'EFC4B9'),
          ],
        ),
        Row(
          children: [
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Studying-pana.png',
                height: 180,
                width: 180,
                pos: 0,
                hexColorCode: 'FDBC96'),
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Webinar-amico.png',
                height: 180,
                width: 180,
                pos: 0,
                hexColorCode: 'DAC2CF'),
          ],
        ),
        Row(
          children: [
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Research paper-amico.png',
                height: 180,
                width: 180,
                pos: 0,
                hexColorCode: 'E1D4C3'),
            miniCard(
                title: 'Basic Profile',
                imgPath: 'assets/vector/Recommendation letter-amico.png',
                height: 180,
                width: 180,
                pos: 0,
                hexColorCode: 'BAC9CE'),
          ],
        ),
      ],
    );
  }
}
