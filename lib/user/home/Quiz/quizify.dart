import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/button/vybutton_.dart';

import 'Quiz.dart';


class Quizyfy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Quizyfy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'flutter')),
                );
              },
              child: Text('Flutter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'react')),
                );
              },
              child: Text('React'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'backend_web')),
                );
              },
              child: Text('backend_web'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'pandas')),
                );
              },
              child: Text('pandas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'deep_learning')),
                );
              },
              child: Text('deep_learning'),
            ),ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'machinelearning')),
                );
              },
              child: Text('machinelearning'),
            ),ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'frontendweb')),
                );
              },
              child: Text('frontendweb'),
            ),ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'kotlin_app')),
                );
              },
              child: Text('kotlin_app'),
            ),ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VyQuiz(category: 'jetpack_compose')),
                );
              },
              child: Text('jetpack_compose'),
            ),

          ],
        ),
      ),
    );
  }
}
