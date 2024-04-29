// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/school/tenth_ac.dart';
import 'package:kiit_connect/user/member/school/tenth_achievements.dart';
import 'package:kiit_connect/user/member/school/twelfth_achievements.dart';
import 'package:kiit_connect/user/member/school/twelth_ac.dart';
import 'package:kiit_connect/user/member/sem/eighth_sem.dart';
import 'package:kiit_connect/user/member/sem/fifth_sem.dart';
import 'package:kiit_connect/user/member/sem/first_sem.dart';
import 'package:kiit_connect/user/member/sem/fourth_sem.dart';
import 'package:kiit_connect/user/member/sem/second_sem.dart';
import 'package:kiit_connect/user/member/sem/seventh_sem.dart';
import 'package:kiit_connect/user/member/sem/sixth_sem.dart';
import 'package:kiit_connect/user/member/sem/third_sem.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import '../../navigation/drawer.dart';
import '../../theme/utils/ThemeBackgrounds.dart';
import '../../theme/utils/cards.dart';
import '../member/basicprofile.dart';

class RevampedHome extends StatefulWidget {
  const RevampedHome({super.key});

  @override
  State<RevampedHome> createState() => _RevampedHomeState();
}


class _RevampedHomeState extends State<RevampedHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  PageController pageController = PageController();
  int selectedIndex = -1; // -1 means no icon is selected
  

  @override
  Widget build(BuildContext context) {

    var profile = ColorProfile();
    double width = MediaQuery.of(context).size.width;
    double width_7 = 411.00;
    double invWidth7 = 1/width_7;
    var filter; // profile.imageTransformationMatrix(target: profile.roots1);
    final colors = StatefulColorChain(profile);


    return Scaffold(
      drawer: SideDrawer(),
        key: _scaffoldKey,
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: padWrap(
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child:IconButton(
                      icon: Icon(FluentIcons.list_24_filled,color: Colors.white,),
                      onPressed:_openDrawer,

                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back!", style: textTitle(context)),
                      Text("${FirebaseAuth.instance.currentUser!.displayName!}" ,
                        style: TextStyle(color: primary, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              smallSpacing(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: (15.00 * invWidth7)*width),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: profile.background,
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 1',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FirstSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 2',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SecondSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 3',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ThirdSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 4',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FourthSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 5',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FifthSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 6',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SixthSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 7',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SeventhSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.article_outlined,
                                color: primary,
                              ),
                              title: Text(
                                'Semester 8',
                                style: TextStyle(color: primary),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EightSemesterPerformance(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: HaveThisCard(
                    curvature: 20,
                    height: 200,
                    width: 400,
                    gradient: profile.randomRadialGradient(colors.next()),
                    image: ThemedBackground.home.bigDeco(colorFilter: filter),
                    theChild:
                        Text("Semester-Wise Report", style: textTitle(context)),
                  ),
                ),
              ),
              smallSpacing(),
              Padding(
                padding: EdgeInsets.only(left: 10*invWidth7*width, right: 10*invWidth7*width),
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BasicProfile()));
                          },
                          child: HaveThisCard(
                            curvature: 20,
                            height: 150,
                            width: 180*invWidth7*width,
                            gradient:
                            profile.randomRadialGradient(colors.next()),
                            image: ThemedBackground.basicProfile.smallDeco(),
                            theChild: Text("Basic Profile",
                                style: textTitle(context)),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Competency()));
                          },
                          child: HaveThisCard(
                            curvature: 20,
                            height: 300,
                            width: 180*invWidth7*width,
                            gradient:
                            profile.randomRadialGradient(colors.next()),
                            image: ThemedBackground.competency.smallDeco(),
                            theChild:
                                Text("Skills", style: textTitle(context)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10*invWidth7*width),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CollegeExperience()));
                          },
                          child: HaveThisCard(
                            curvature: 20,
                            height: 300,
                            width: 180*invWidth7*width,
                            gradient: profile.randomRadialGradient(colors.next()),
                            image:
                                ThemedBackground.collegeExperience.smallDeco(),
                            theChild: Text("College Experience",
                                style: textTitle(context)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PublicProfile()));
                          },
                          child: HaveThisCard(
                            curvature: 20,
                            height: 150,
                            width: 180*invWidth7*width,
                            gradient: profile.randomRadialGradient(colors.next()),
                            image: ThemedBackground.publicLinks.smallDeco(),
                            theChild:
                                Text("Public Links", style: textTitle(context)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              smallSpacing(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TenthGradeInfo()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 300,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.tenthDetails.bigDeco(),
                          theChild: Text("10th/Matric Academics",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TwelfthGradeInfo()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 300,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.twelfthDetails.bigDeco(),
                          theChild: Text("12th/Inter Academics",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TenthGradeAchievements()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 300,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.tenthAchievements.bigDeco(),
                          theChild: Text("Achievements upto Matric/10th",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TwelfthGradeAchievements()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 300,
                          gradient: profile.randomRadialGradient(colors.next()),
                          // no image was found for twelfthAchievements, kindly handle the next line if image found!
                          image: ThemedBackground.extraCertifications.bigDeco(),
                          theChild: Text("Achievements upto Inter/12th",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              smallSpacing(),
              Padding(
                padding: EdgeInsets.only(left: 10*invWidth7*width, right: 10*invWidth7*width),
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AcademicAchievements()));
                          },
                          child: HaveThisCard(
                            curvature: 20,
                            height: 400,
                            width: 180*invWidth7*width,
                            gradient:
                            profile.randomRadialGradient(colors.next()),
                            image: ThemedBackground.discoverSomethingNew
                                .bigDeco(),
                            theChild: Text("Research Work",
                                style: textTitle(context)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10*invWidth7*width),
                    Column(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartupInformation()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 180*invWidth7*width,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image:
                              ThemedBackground.startupInformation.smallDeco(),
                          theChild: Text("StartUps", style: textTitle(context)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalProject()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 180,
                          width: 180*invWidth7*width,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.personalProjects.smallDeco(),
                          theChild: Text("Projects", style: textTitle(context)),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              smallSpacing(),
              // 2nd Horiozontal ListView
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfessionalExperience()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 200,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.tenthDetails.bigDeco(),
                          theChild: Text("Professional Experience",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExtraCertifications()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 200,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.twelfthDetails.bigDeco(),
                          theChild: Text("Certifications",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecommendationsAndTestimonials()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 200,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.tenthAchievements.bigDeco(),
                          theChild: Text("Recommendations",
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LanguageProficiency()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 200,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.extraCertifications.bigDeco(),
                          theChild: Text("Language Proficiency",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LanguageProficiency()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 200,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.extraCertifications.bigDeco(),
                          theChild: Text("Language Proficiency",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OpenSourceContributions()));
                        },
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 200,
                          gradient: profile.randomRadialGradient(colors.next()),
                          image: ThemedBackground.extraCertifications.bigDeco(),
                          theChild: Text("Open Source Contributions",
                              style: textTitle(context)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
