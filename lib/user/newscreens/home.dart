// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kiit_connect/drawer/drawer.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kiit_connect/user/member/school/tenth_ac.dart';
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
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: padWrap(
            Column(
              children: [
                smallSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: greenHighlight,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                smallSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: TextStyle(color: primary, fontSize: 20),
                    ),
                  ],
                ),
                smallSpacing(),
                MyIfElseCarousel(),
                smallSpacing(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Profiling Progress",
                      style: TextStyle(
                        color: primary,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                smallSpacing(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BasicProfile(),
                      ),
                    );
                  },
                  child: Container(
                    width: 384,
                    height: 125,
                    decoration: BoxDecoration(
                        color: darkHighlight,
                        borderRadius: BorderRadius.circular(10.0)),
                    // padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Basic Profile",
                        style: TextStyle(
                          fontSize: 25,
                          color: primary,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ),
                ),
                smallSpacing(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: darkShadow,
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
                  child: Container(
                    width: 384,
                    height: 125,
                    decoration: BoxDecoration(
                        color: darkHighlight,
                        borderRadius: BorderRadius.circular(10.0)),
                    // padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Semester-Wise Performance",
                        style: TextStyle(
                          fontSize: 25,
                          color: primary,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ),
                ),
                smallSpacing(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfessionalExperience(),
                      ),
                    );
                  },
                  child: Container(
                    width: 384,
                    height: 125,
                    decoration: BoxDecoration(
                        color: darkHighlight,
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Internship Report",
                        style: TextStyle(
                          fontSize: 25,
                          color: primary,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ),
                ),
                smallSpacing(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Competency(),
                      ),
                    );
                  },
                  child: Container(
                    width: 384,
                    height: 125,
                    decoration: BoxDecoration(
                        color: darkHighlight,
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Skill Upgradation",
                        style: TextStyle(
                          fontSize: 25,
                          color: primary,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyIfElseCarousel extends StatelessWidget {
  final List<String> titles = [
    'Update 10th/Matric Information',
    'Update 12th/High School Information',
    'Update Internship Information',
    'Update Semester Information'
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
      ),
      items: titles.map((title) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                if (title == 'Update 10th/Matric Information') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TenthGradeInfo(),
                    ),
                  );
                } else if (title == 'Update 12th/High School Information') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TwelfthGradeAchievements(),
                    ),
                  );
                } else if (title == 'Update Internship Information') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfessionalExperience()));
                } else if (title == 'Update Semester Information') {
                  showModalBottomSheet(
                    backgroundColor: darkShadow,
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
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: greenHighlight,
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(color: Colors.white, width: 4.0),
                ),
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: loginPrimary,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
