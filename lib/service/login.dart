import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          onPressed: _handleSignIn,
        ),
      ),
    );
  }
}
