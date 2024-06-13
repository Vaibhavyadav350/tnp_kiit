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
import 'package:kiit_connect/user/member/work/language_proficiency.dart';
import 'package:kiit_connect/user/member/work/open_source_contributions.dart';
import 'package:kiit_connect/user/member/work/participation_in_researches.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/member/work/recommendations_and_testimonials.dart';
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
                    imgPath: 'assets/vector/Profile data-pana.png',
                    height: 180,
                    width: 180,
                    rightPos: -10,
                    bottomPos: -50,
                    imgwidth: 200,
                    toastMessage: "View and Edit your profile information",
                    hexColorCode: 'D3E3D6'),
                miniCard(
                    context: context,
                    title: 'Skills',
                    nextRoute: Competency(),
                    imgPath: 'assets/vector/Bibliophile-cuate.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: -20,
                    bottomPos: -20,
                    toastMessage: "Showcase your skills and competencies",
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
                    toastMessage: "Highlight your college experiences",
                    hexColorCode: 'EFC4B9'),
                miniCard(
                    context: context,
                    nextRoute: PublicProfile(),
                    title: 'Public Links',
                    imgPath: 'assets/vector/Social media-bro.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    bottomPos: -20,
                    hexColorCode: 'BAC9CE',
                    toastMessage: "Add links to your public profiles"),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                  title: '10th\nHighlights',
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
                  title: '12th\nHighlights',
                  imgPath: 'assets/vector/Research paper-amico.png',
                  height: 180,
                  width: 400,
                  pos: -160,
                  titlepos: 50,
                  titleSize: 25,
                  textcolor: '37474F',
                  hexColorCode: 'E1D4C3'),
              SizedBox(
                height: 220,
              )
            ],
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
                    title: 'Research\nWork',
                    nextRoute: AcademicAchievements(),
                    imgPath: 'assets/vector/Medical research-rafiki.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: -20,
                    bottomPos: -30,
                    toastMessage: 'Update your research work and papers',
                    hexColorCode: 'BEC1AC'),
                miniCard(
                    context: context,
                    title: 'Certificates',
                    nextRoute: ExtraCertifications(),
                    imgPath: 'assets/vector/Certification-rafiki.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    bottomPos: -25,
                    toastMessage: 'Show your certificates and courses',
                    hexColorCode: 'BAC9CE'),
              ],
            ),
            Column(
              children: [
                miniCard(
                    context: context,
                    nextRoute: PersonalProject(),
                    title: 'Projects',
                    imgPath: 'assets/vector/Researching-bro.png',
                    height: 180,
                    width: 180,
                    rightPos: 0,
                    bottomPos: -35,
                    toastMessage: 'Display your personal projects',
                    hexColorCode: 'FDBC96'),
                miniCard(
                    context: context,
                    title: 'Professional\nExperience',
                    nextRoute: ProfessionalExperience(),
                    imgPath: 'assets/vector/Work time-amico.png',
                    height: 300,
                    width: 180,
                    imgwidth: 230,
                    rightPos: -20,
                    bottomPos: -30,
                    hexColorCode: 'C1D7FF',
                    toastMessage: 'Detail your professional experience'),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              miniCard(
                  context: context,
                  title: 'Start-Ups',
                  nextRoute: StartupInformation(),
                  imgPath: 'assets/vector/Business Plan-amico.png',
                  height: 180,
                  width: 180,
                  rightPos: 0,
                  toastMessage: 'Showcase your start-up ventures',
                  hexColorCode: 'F5E8D7'),
              miniCard(
                  context: context,
                  title: 'Referrals',
                  fontSize: 22.0,
                  nextRoute: RecommendationsAndTestimonials(),
                  imgPath: 'assets/vector/Recommendation letter-amico.png',
                  height: 180,
                  width: 180,
                  rightPos: 0,
                  hexColorCode: 'ECD1BE',
                  toastMessage: 'Input your referrals and testimonials'),
              miniCard(
                  context: context,
                  title: 'Language\nProficiency',
                  nextRoute: LanguageProficiency(),
                  imgPath: 'assets/vector/Studying-pana.png',
                  toastMessage: "Show your programming language proficiency",
                  height: 180,
                  width: 180,
                  rightPos: 0,
                  hexColorCode: 'C1D7FF'),
              miniCard(
                  context: context,
                  title: 'Coding\nProfiles',
                  nextRoute: LanguageProficiency(),
                  imgPath: 'assets/vector/basicpro.png',
                  height: 180,
                  width: 180,
                  rightPos: 0,
                  bottomPos: -18,
                  toastMessage: 'Showcase your coding profiles',
                  hexColorCode: 'BAC9CE'),
              miniCard(
                  context: context,
                  title: 'Open-Source\nContributions',
                  fontSize: 20,
                  nextRoute: OpenSourceContributions(),
                  imgPath: 'assets/vector/Open source-amico.png',
                  height: 180,
                  width: 180,
                  bottomPos: -35,
                  rightPos: 4,
                  hexColorCode: 'DAC2CF',
                  toastMessage: 'Show your open-source contributions'),
              SizedBox(
                height: 230,
              )
            ],
          ),
        ),
        smallSpacing(),
        smallSpacing(),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
