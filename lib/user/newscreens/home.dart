// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kiit_connect/drawer/drawer.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
import 'package:kiit_connect/user/member/work/participation_in_researches.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/member/work/startups.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: greenHighlight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "Testing....",
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: TextStyle(color: primary, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasicProfile()));
                      },
                      child: SizedBox(
                          height: 45,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(100),
                          // ),
                          child: Image.asset('assets/images/profile-edit.png')),
                    )
                  ],
                ),
                smallSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Education Details",
                      style: TextStyle(
                        color: primary,
                        fontSize: 21,
                      ),
                    )
                  ],
                ),
                smallSpacing(),
                MyIfElseCarousel(),
                smallSpacing(),
                smallSpacing(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Profiling Progress",
                      style: TextStyle(
                        color: primary,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),
                smallSpacing(),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //skills button
                      Column(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Competency()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white60,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              child: Center(
                                child: Image.asset('assets/images/user.png'),
                              )),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Skills',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),

                      Column(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfessionalExperience()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white60,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              child: Center(
                                child:
                                    Image.asset('assets/images/workspace.png'),
                              )),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Internships',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Column(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonalProject()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white60,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              padding: EdgeInsets.all(10),
                              height: 90,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/computer.png',
                                  scale: 0.1,
                                ),
                              )),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Projects',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ])
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AcademicAchievements()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 100,
                              child: Image.asset('assets/images/searching.png'),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Research Work",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Share and update your\nresearch projects here",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      smallSpacing(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartupInformation()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 92,
                              // width: 75,
                              child: Image.asset('assets/images/rocket.png'),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Start Ups",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  " Share and update your\n Start-Up projects here",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      smallSpacing(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyIfElseCarousel extends StatefulWidget {
  @override
  State<MyIfElseCarousel> createState() => _MyIfElseCarouselState();
}

class _MyIfElseCarouselState extends State<MyIfElseCarousel> {
  final _controller = PageController();
  final List<String> titles = [
    'Update 10th/Matric Information',
    'Update 12th/High School Information',
    'Update Semester Information'
  ];
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 2),
            onPageChanged: (index, reason) {
              setState(() {
                idx = index;
              });
            }),
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
                    // Internship details not needed on the educational details section
                    // } else if (title == 'Update Internship Information') {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => ProfessionalExperience()));
                    // }
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
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF4EEA00), // Light Green
                        Color(0xFFF5F106), // Dark Green
                      ],
                    ),
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
      ),
      smallSpacing(),
      AnimatedSmoothIndicator(
        activeIndex: idx,
        count: titles.length,
        effect: WormEffect(
            activeDotColor: Colors.blueAccent, dotHeight: 10, dotWidth: 20),
      ),
    ]);
  }
}
