import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../theme/colors.dart';

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
class SpadhScreen extends StatefulWidget {
  @override
  _SpadhScreen createState() => _SpadhScreen();
}

class _SpadhScreen extends State<SpadhScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Check for the specific domain
    if (!googleUser!.email.endsWith('@kiit.ac.in')) {
      print('Invalid domain. Please use a valid @kiit.ac.in email.');
      return;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;

    // Check if the UID already exists in the 'users' collection
    final userDoc = await _firestore.collection('users').doc(user?.uid).get();
    if (!userDoc.exists) {
      // UID doesn't exist, so save the auth id to Firestore
      _firestore.collection('users').doc(user?.uid).set({
        'uid': user?.uid,
        'kiitemail': user?.email,
        // add other user information here if needed
      });
    }

    // Check if the email already exists in the 'StudentInfo' collection
    final emailDoc =
    await _firestore.collection('StudentInfo').doc(user?.uid).get();
    if (!emailDoc.exists) {
      // Email doesn't exist, so save the information to Firestore
      _firestore.collection('StudentInfo').doc(user?.uid).set({
        'kiitemail': user?.email,
        // add other user information here if needed
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
    return Container(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: Container(
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
                              style: TextStyle(
                                fontSize: 34,
                                fontFamily: "Billy",
                                fontWeight: FontWeight.bold,
                              ),textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20,),
                            Text(
                              data[index].text2,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Billy",
                                fontWeight: FontWeight.w500,
                              ),textAlign: TextAlign.center,
                            ),
                            Text(
                              data[index].text3,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Billy",
                                fontWeight: FontWeight.normal,
                              ),textAlign: TextAlign.center,
                            ),
                            if (index == data.length - 1)
                              SizedBox(
                                height: 50,width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: buttoncolor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                    minimumSize: Size(300, 60), //////// HERE
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
                                      Text('   Login',style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios,color: Colors.white,),
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
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
  const ExampleSlider({Key? key}) : super(key: key);

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
