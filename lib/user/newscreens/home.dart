// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiit_connect/drawer/drawer.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kiit_connect/utils/tile_button.dart';
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
                      "Testing....",
                      // FirebaseAuth.instance.currentUser!.displayName!,
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
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              child: TiledButton(
                                buttonText: "Skills",
                                iconImagePath: "assets/images/user.png",
                              )),
                        ]),
                        Column(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalProject()));
                              },
                              child: TiledButton(
                                buttonText: "Projects",
                                iconImagePath: "assets/images/file.png",
                              )),
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
                              child: TiledButton(
                                buttonText: "Internships",
                                iconImagePath: "assets/images/workspace.png",
                              )),
                        ]),
                        Column(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Competency()));
                              },
                              child: TiledButton(
                                buttonText: "Certifications",
                                iconImagePath: "assets/images/coming-soon.png",
                              )),
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Competency()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: TiledButton(
                                buttonText: "  Open-Source\n  Contributions",
                                iconImagePath: "assets/images/coming-soon.png",
                              ),
                            ),
                          ),
                        ]),
                        Column(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Competency()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: TiledButton(
                                  buttonText: "Coding\n Platforms",
                                  iconImagePath:
                                      "assets/images/coming-soon.png",
                                ),
                              )),
                        ]),
                      ],
                    ),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 100,
                                child:
                                    Image.asset('assets/images/searching.png'),
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
                          Color.fromARGB(255, 255, 238, 207),
                          Color.fromARGB(255, 255, 238, 207),

                          // Color.fromARGB(200, 75, 255, 79),
                          // Color.fromARGB(200, 75, 255, 79),
                          Color.fromARGB(255, 255, 238, 207),
                          Color.fromARGB(255, 255, 238, 207),
                          // Color.fromARGB(200, 75, 255, 79),
                          // Color.fromARGB(200, 75, 255, 79),
                          Color.fromARGB(255, 255, 238, 207),
                          Color.fromARGB(255, 255, 238, 207),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Sawarabi Mincho',
                          fontWeight: FontWeight.w900,
                          fontSize: 24.0,
                          color: Colors.black
                        )
                        //     TextStyle(
                        //   fontFamily: 'Google',
                        //   fontWeight: FontWeight.w500,
                        //   fontSize: 24.0,
                        //   color: loginPrimary,
                        // ),
                      ),
                    ),
                    // width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(0.2),
                    //       spreadRadius: 5,
                    //       blurRadius: 10,
                    //       offset: Offset(0, 3),
                    //     ),
                    //   ],
                    //   gradient: LinearGradient(
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //     colors: [
                    //       Color.fromARGB(120,255, 255, 255),
                    //       Color.fromARGB(10,255, 255, 255),
                    //       Color.fromARGB(60,255, 255, 255),
                    //     ],
                    //   ),
                    // ),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    //     child: Center(
                    //       // child: Text(
                    //       //   title,
                    //       //   textAlign: TextAlign.center,
                    //       //   style: TextStyle(
                    //       //     fontFamily: 'Times New Roman',
                    //       //     fontWeight: FontWeight.w500,
                    //       //     fontSize: 24.0,
                    //       //     color:
                    //       //         Colors.white, // Adjust text color as needed
                    //       //   ),
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                  ));
            },
          );
        }).toList(),
      ),
      SizedBox(height: 10,),
      AnimatedSmoothIndicator(
        activeIndex: idx,
        count: titles.length,
        effect: WormEffect(
            activeDotColor: Colors.blueAccent, dotHeight: 10, dotWidth: 10
        ),
      ),
    ]);
  }
}
