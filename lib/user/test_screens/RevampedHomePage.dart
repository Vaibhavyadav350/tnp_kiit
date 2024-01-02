// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/utils/ThemeBackgrounds.dart';
import 'package:kiit_connect/utils/cards.dart';

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
    var profile = ColorProfile();
    final colors = StatefulColorChain(profile);
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
                        Text("Welcome Back!", style: textTitle(context)),
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
                        gradient: profile.randomRadialGradient(colors.next()),
                        image: ThemedBackground.home.bigDeco(),
                        theChild: Text("Home", style: textTitle(context)),
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
                                  gradient:
                                  profile.randomRadialGradient(colors.next()),
                                  image: ThemedBackground.basicProfile.smallDeco(),
                                  theChild: Text("Basic Profile", style: textTitle(context)),
                                ),
                                SizedBox(height: 20),
                                HaveThisCard(
                                  curvature: 20,
                                  height: 300,
                                  width: 180,
                                  gradient:
                                  profile.randomRadialGradient(colors.next()),
                                  image: ThemedBackground.competency.smallDeco(),
                                  theChild: Text("Competency", style: textTitle(context)),
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
                                gradient:
                                profile.randomRadialGradient(colors.next()),
                                image: ThemedBackground.collegeExperience.smallDeco(),
                                theChild: Text("College Experience", style: textTitle(context)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              HaveThisCard(
                                curvature: 20,
                                height: 150,
                                width: 180,
                                gradient:
                                profile.randomRadialGradient(colors.next()),
                                image: ThemedBackground.publicLinks.smallDeco(),
                                theChild: Text("Public Links", style: textTitle(context)),
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
      // bottomNavigationBar:
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
