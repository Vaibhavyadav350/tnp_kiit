import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiit_connect/user/developers/about.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../theme/colors.dart';
import '../developers/admin.dart';

/// Class to hold data for itembuilder in Withbuilder app.
class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

/// Example of LiquidSwipe with itemBuilder
class LiquidSplashScreen extends StatefulWidget {
  const LiquidSplashScreen({super.key});

  @override
  _LiquidSplashScreen createState() => _LiquidSplashScreen();
}

class _LiquidSplashScreen extends State<LiquidSplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    if (!googleUser!.email.endsWith('@kiit.ac.in')) {
      print('Invalid domain. Please use a valid @kiit.ac.in email.');
      return;
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final User? user = (await _auth.signInWithCredential(credential)).user;
    final userDoc = await _firestore.collection('users').doc(user?.uid).get();
    if (!userDoc.exists) {
      _firestore.collection('users').doc(user?.uid).set({
        'uid': user?.uid,
        'kiitemail': user?.email,

      });
    }
    final emailDoc =
    await _firestore.collection('StudentInfo').doc(user?.uid).get();
    if (!emailDoc.exists) {
      _firestore.collection('StudentInfo').doc(user?.uid).set({
        'kiitemail': user?.email,
      });
    }

    print('Signed in as ${user?.displayName}');
  }
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> data = [
    ItemData(paleBlue, "assets/images/splash/profile.svg", "Welcome Aboard!", "Manage your profiles for career placements.", ""),
    ItemData(palePink, "assets/images/splash/feed.svg", "Craft Your Tech Portfolio Here.", "Showcase your expertise and projects to captivate recruiters!", ""),
    ItemData(paleYellow, "assets/images/splash/Resume.svg", "Effortless Resume Upload.", "Stand out to potential employers with ease!", ""),
    ItemData(mintGreen , "assets/images/splash/work.svg", "Share Your Latest Projects.", "Engage with peers and recruiters through your innovations!", ""),
    ItemData(peach, "assets/images/splash/findjob.svg", "Stay Updated on Job Opportunities.", "Discover exciting career prospects with new companies!", ""),
    ItemData(beige, "assets/images/splash/interview.svg", "Log In to Embark on Your Career Journey.", "Initiate your career journey today!", ""),
  ];


  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SvgPicture.asset(
                        data[index].image,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.all(index != 4 ? 24.0 : 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              data[index].text1,
                              style: const TextStyle(
                                fontSize: 34,
                                fontFamily: "Billy",
                                fontWeight: FontWeight.bold,
                              ),textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20,),
                            Text(
                              data[index].text2,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "Billy",
                                fontWeight: FontWeight.w500,
                              ),textAlign: TextAlign.center,
                            ),
                            Text(
                              data[index].text3,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Billy",
                                fontWeight: FontWeight.normal,
                              ),textAlign: TextAlign.center,
                            ),
                            if (index == data.length - 1)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 50,width: 300,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttoncolor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0)),
                                        minimumSize: const Size(300, 60), //////// HERE
                                      ),

                                      onPressed: () {
                                        _handleSignIn();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/Group 13.png",
                                            fit: BoxFit.cover,

                                          ),
                                          const Text('   Login',style: TextStyle(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Login as ',style: TextStyle(color: Colors.black),),
                                      GestureDetector(
                                          onTap:(){
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => AdminPageLogin()),
                                            );
                                          },
                                          child: const Text('Admin',style: TextStyle(color: Colors.blue),)),
                                    ],
                                  ),
                                ],
                              ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: const Icon(Icons.arrow_back_ios,color: Colors.white,),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              preferDragFromRevealedArea: true,
              enableLoop: false,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

class ExampleSlider extends StatefulWidget {
  const ExampleSlider({super.key});

  @override
  State<ExampleSlider> createState() => _ExampleSliderState();
}

class _ExampleSliderState extends State<ExampleSlider> {
  double sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: sliderVal,
      activeColor: Colors.white,
      inactiveColor: Colors.red,
      onChanged: (val) {
        setState(() {
          sliderVal = val;
        });
      },
    );
  }
}
