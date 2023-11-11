import 'package:flutter/material.dart';
import 'package:kiit_connect/drawer/drawer.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kiit_connect/user/member/sem/first_sem.dart';
import 'package:kiit_connect/user/member/work/collegeexp.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: padWrap(Column(
                children: [
                  smallSpacing(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Welcome Back!",
                          style: TextStyle(
                            color: greenHighlight,
                            fontSize: 12,
                          ))
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Mayank Singh", // name will be taken from firebase/google account
                          style: TextStyle(
                            color: primary,
                            fontSize: 23,
                          ))
                    ],
                  ),
                  smallSpacing(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Educational Details",
                          style: TextStyle(color: primary, fontSize: 20))
                    ],
                  ),
                  smallSpacing(),
                  CarouselSlider(
                    options: CarouselOptions(height: 175.0),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration:
                                  const BoxDecoration(color: greenHighlight),
                              child: Text(
                                'text $i',
                                style: const TextStyle(fontSize: 16.0),
                              ));
                        },
                      );
                    }).toList(),
                  ),
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
                      )
                    ],
                  ),
                  smallSpacing(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BasicProfile()));
                    },
                    child: Container(
                      width: 384,
                      height: 125,
                      color: darkHighlight,
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Basic Profile",
                        style: TextStyle(
                          fontSize: 21,
                          color: primary,
                          fontFamily: 'Times New Roman',
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
                              builder: (context) => FirstSemesterPerformance()));
                    },
                    child: Container(
                      width: 384,
                      height: 125,
                      color: darkHighlight,
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Semester Wise Performance",
                        style: TextStyle(
                          fontSize: 21,
                          color: primary,
                          fontFamily: 'Times New Roman',
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
                              builder: (context) => ProfessionalExperience()));
                    },
                    child: Container(
                      width: 384,
                      height: 125,
                      color: darkHighlight,
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Internship Report",
                        style: TextStyle(
                          fontSize: 21,
                          color: primary,
                          fontFamily: 'Times New Roman',
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
                              builder: (context) => CollegeExperience()));
                    },
                    child: Container(
                      width: 384,
                      height: 125,
                      color: darkHighlight,
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "CollegeExperience",
                        style: TextStyle(
                          fontSize: 21,
                          color: primary,
                          fontFamily: 'Times New Roman',
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
                              builder: (context) => PersonalProject()));
                    },
                    child: Container(
                      width: 384,
                      height: 125,
                      color: darkHighlight,
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Projects",
                        style: TextStyle(
                          fontSize: 21,
                          color: primary,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                  ),
                  
                ],
              )))),
    );
  }
}
