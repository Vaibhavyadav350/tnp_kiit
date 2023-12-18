// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/test_screens/navBar.dart';
import 'package:kiit_connect/utils/cards.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kiit_connect/user/test_screens/navBar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';


import '../member/basicprofile.dart';

class RevampedHome extends StatefulWidget {
  const RevampedHome({super.key});

  @override
  State<RevampedHome> createState() => _RevampedHomeState();
}

class _RevampedHomeState extends State<RevampedHome> {
  PageController pageController = PageController();
  int selectedIndex = -1; // -1 means no icon is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              color: Colors.white,
                              fontSize: 30,
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
                                child: Image.asset(
                                    'assets/images/profile-edit.png')),
                          ),
                        ],
                      ),
                      smallSpacing(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: HaveThisCard(
                          curvature: 20,
                          height: 200,
                          width: 400,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.lightGreenAccent.withOpacity(0.20),
                              Color.fromARGB(255, 80, 234, 255).withOpacity(
                                  0.20)
                            ],
                          ),
                        ),
                      ),
                      smallSpacing(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  HaveThisCard(
                                    curvature: 20,
                                    height: 150,
                                    width: 180,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.cyan.shade400.withOpacity(0.30),
                                        Colors.green.shade600.withOpacity(0.20),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  HaveThisCard(
                                    curvature: 20,
                                    height: 300,
                                    width: 180,
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Colors.lightGreenAccent.withOpacity(
                                            0.20),
                                        Colors.yellowAccent.withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                HaveThisCard(
                                  curvature: 20,
                                  height: 300,
                                  width: 180,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.lightBlueAccent.withOpacity(0.20),
                                      Colors.lightGreenAccent.withOpacity(0.20)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                HaveThisCard(
                                  curvature: 20,
                                  height: 150,
                                  width: 180,
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.yellow.withOpacity(0.4),
                                      Colors.greenAccent.withOpacity(0.20)
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      smallSpacing(),
                    ],
                  ),
                ))),
        bottomNavigationBar:
        // WaterDropNavBar(
        //   bottomPadding: 20,
        //   backgroundColor: Colors.white,
        //   onItemSelected: (index) {
        //     setState(() {
        //       selectedIndex = index;
        //     });
        //     pageController.animateToPage(selectedIndex,
        //         duration: const Duration(milliseconds: 400),
        //         curve: Curves.easeOutQuad);
        //   },
        //   selectedIndex: selectedIndex,
        //   barItems: [
        //     BarItem(
        //       filledIcon: Icons.bookmark_rounded,
        //       outlinedIcon: Icons.bookmark_border_rounded,
        //     ),
        //     BarItem(
        //         filledIcon: Icons.favorite_rounded,
        //         outlinedIcon: Icons.favorite_border_rounded),
        //     BarItem(
        //         filledIcon: Icons.favorite_rounded,
        //         outlinedIcon: Icons.favorite_border_rounded),
        //     BarItem(
        //         filledIcon: Icons.favorite_rounded,
        //         outlinedIcon: Icons.favorite_border_rounded),
        //   ],
        // ),


    );
  }


}


