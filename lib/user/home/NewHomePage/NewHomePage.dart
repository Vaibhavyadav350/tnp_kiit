// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/home/NewHomePage/Components/MiniCard.dart';
import 'package:kiit_connect/user/home/utils/buildBottomShit.dart';
import 'package:kiit_connect/user/home/utils/device_variables.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:kiit_connect/user/member/school/tenth_ac.dart';
import 'package:kiit_connect/user/member/school/tenth_achievements.dart';
import 'package:kiit_connect/user/member/school/twelfth_achievements.dart';
import 'package:kiit_connect/user/member/school/twelth_ac.dart';
import 'package:kiit_connect/user/member/skill/competency.dart';
import 'package:kiit_connect/user/member/skill/extcourses.dart';
import 'package:kiit_connect/user/member/skill/publiclinks.dart';
import 'package:kiit_connect/user/member/work/college_experience.dart';
import 'package:kiit_connect/user/member/work/participation_in_researches.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/member/work/startups.dart';

import 'Components/HeroCard.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              elevation: 100,
                context: context,
                builder: (context) {
                  return buildModalBottomSheet(context);
                });
          },
          child: HeroCard(
              title: 'Semester\nWise\nReport',
              imgPath: 'assets/vector/Research paper-amico.png',
              height: 180,
              width: 400,
              pos: -160,
              titlepos: 50,
              titleSize: 25,
              textcolor: '37474F',
              hexColorCode: 'E1D4C3',
              context: context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                miniCard(
                    context: context,
                    title: 'Basic Profile',
                    nextRoute: BasicProfile(),
                    imgPath: 'assets/vector/basicpro.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    bottomPos: -20,
                    imgwidth: 200,
                    hexColorCode: 'D3E3D6'),
                miniCard(
                    context: context,
                    title: 'Skills',
                    nextRoute: Competency(),
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
                    context: context,
                    nextRoute: CollegeExperience(),
                    title: 'College \nExperience',
                    imgPath: 'assets/vector/boy on graduation-cuate.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: -20,
                    bottomPos: -20,
                    hexColorCode: 'EFC4B9'),
                miniCard(
                    context: context,
                    nextRoute: PublicProfile(),
                    title: 'Public Links',
                    imgPath: 'assets/vector/Studying-pana.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    hexColorCode: 'BAC9CE'),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HeroCard(
                    context: context,
                    nextRoute: TenthGradeInfo(),
                    title: '10th\nAcademics',
                    imgPath: 'assets/vector/Research paper-amico.png',
                    height: 180,
                    width: 400,
                    pos: -160,
                    titlepos: 50,
                    titleSize: 25,
                    textcolor: '37474F',
                    hexColorCode: 'E1D4C3'),
                HeroCard(
                    context: context,
                    nextRoute: TenthGradeAchievements(),
                    title: '10th\nAchievements',
                    imgPath: 'assets/vector/Research paper-amico.png',
                    height: 180,
                    width: 400,
                    pos: -160,
                    titlepos: 50,
                    titleSize: 25,
                    textcolor: '37474F',
                    hexColorCode: 'E1D4C3'),
                HeroCard(
                    context: context,
                    nextRoute: TwelfthGradeInfo(),
                    title: '12th\nAcademics',
                    imgPath: 'assets/vector/Research paper-amico.png',
                    height: 180,
                    width: 400,
                    pos: -160,
                    titlepos: 50,
                    titleSize: 25,
                    textcolor: '37474F',
                    hexColorCode: 'E1D4C3'),
                HeroCard(
                    context: context,
                    nextRoute: TwelfthGradeAchievements(),
                    title: '12th\nAchievements',
                    imgPath: 'assets/vector/Research paper-amico.png',
                    height: 180,
                    width: 400,
                    pos: -160,
                    titlepos: 50,
                    titleSize: 25,
                    textcolor: '37474F',
                    hexColorCode: 'E1D4C3'),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                miniCard(
                    context: context,
                    nextRoute: AcademicAchievements(),
                    title: 'Research\nWork',
                    imgPath: 'assets/vector/Recommendation letter-amico.png',
                    height: 495,
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
                    context: context,
                    title: 'Professional\nExperience',
                    nextRoute: ProfessionalExperience(),
                    imgPath: 'assets/vector/boy on graduation-cuate.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: -20,
                    bottomPos: -20,
                    hexColorCode: 'EFC4B9'),
                miniCard(
                    context: context,
                    title: 'Projects',
                    nextRoute: PersonalProject(),
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
                context: context,
                title: 'Start-Ups',
                nextRoute: StartupInformation(),
                imgPath: 'assets/vector/Studying-pana.png',
                height: 180,
                width: 180,
                rightPos: 0,
                hexColorCode: 'BAC9CE'),
            miniCard(
                context: context,
                title: 'Certificates',
                nextRoute: ExtraCertifications(),
                imgPath: 'assets/vector/Studying-pana.png',
                height: 180,
                width: 180,
                rightPos: 0,
                hexColorCode: 'BAC9CE'),
          ],
        ),
        smallSpacing(),
        smallSpacing(),

      ],
    );
  }
}
