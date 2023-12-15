import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/colors.dart';

class Login extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Check for the specific domain
    if (!googleUser!.email.endsWith('@kiit.ac.in')) {
      print('Invalid domain.Please use a valid @kiit.ac.in email.');
      return;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;

    // Save the auth id to Firestore
    _firestore.collection('users').doc(user?.uid).set({
      'uid': user?.uid,
      'kiitemail': user?.email,
      // add other user information here if needed
    });
    _firestore.collection('StudentInfo').doc(user?.uid).set({
      'kiitemail': user?.email,
      // add other user information here if needed
    });

    print('Signed in as ${user?.displayName}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  "assets/images/tnpkiit.png",
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Group 12.png",
                  fit: BoxFit.cover,
                  height: 320,
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "  Manage your \n  Profile for",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "  Placements",
                  style: TextStyle(
                      color: kiitgreen,
                      fontSize: 55,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 40,),
            Expanded(
              child: Center(
                child: SizedBox(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
