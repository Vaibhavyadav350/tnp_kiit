import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/colors.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Constants.kBlackColor,
      extendBody: true,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.1,
              left: -88,
              child: Container(
                height: 166,
                width: 166,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kPinkColor,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 166,
                    width: 166,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.3,
              right: -100,
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kGreenColor,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.07,
                  ),

                  SizedBox(
                    height: screenHeight * 0.09,
                  ),
                  Text(
                    'Watch movies in\nVirtual Reality',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.kWhiteColor.withOpacity(0.85),
                      fontSize: screenHeight <= 667 ? 18 : 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Text(
                    'Download and watch offline\nwherever you are',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.kWhiteColor.withOpacity(0.75),
                      fontSize: screenHeight <= 667 ? 12 : 16,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                          (index) {
                        return Container(
                          height: 7,
                          width: 7,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 0
                                ? Constants.kGreenColor
                                : Constants.kWhiteColor.withOpacity(0.2),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}