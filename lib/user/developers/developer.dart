// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Developers extends StatelessWidget {
  const Developers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: <Widget>[
          smallSpacing(),
          FlutterSlimyCard(
            color: Colors.green,
            topCardHeight: 250,
            bottomCardHeight: 200,
            topCardWidget: topWidgetAnirudh(),
            bottomCardWidget: bottomWidgetAnirudh(),
          ),
          smallSpacing(),
          FlutterSlimyCard(
            color: Colors.blue,
            topCardHeight: 250,
            bottomCardHeight: 200,
            topCardWidget: topWidgetShrey(),
            bottomCardWidget: bottomWidgetShrey(),
          ),
          smallSpacing(),
          FlutterSlimyCard(
            color: Colors.red,
            topCardHeight: 250,
            bottomCardHeight: 160,
            topCardWidget: topWidgetVaibhav(),
            bottomCardWidget: bottomWidgetVaibhav(),
          ),
          smallSpacing(),
          smallSpacing()
        ],
      ),
    ));
  }

  topWidgetVaibhav() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  child: Image(image: AssetImage('assets/images/vaibhav.png')),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Vaibhav Yadav',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/Vaibhavyadav350'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/github.png', height: 70),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/vaibhav-yadav-b20045213/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child:
                        Image.asset('assets/images/linkedin.png', height: 75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  topWidgetAnirudh() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  child: Image(image: AssetImage('assets/images/ani.png')),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Anirudh Sharma',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/Minecraftian14'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/github.png', height: 70),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/minecraftian14/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child:
                        Image.asset('assets/images/linkedin.png', height: 75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  topWidgetShrey() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  child: Image(image: AssetImage('assets/images/shrey.png')
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Shreya Shashank',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/Ayushh1023'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/github.png', height: 70),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse('https://www.linkedin.com/in/ssha512/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child:
                        Image.asset('assets/images/linkedin.png', height: 75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bottomWidgetVaibhav() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: const [
          SizedBox(height: 10),
          Flexible(
              child: Text(
            "As team leader, he guided the development, designed the initial code base for Android and web, handled major refactoring, managed the GitHub repo, integrated Firebase, and worked on application subsystems.",
            style: TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }

  bottomWidgetAnirudh() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
              child: Text(
            'Abstracted UI code for reusability, creating classes for elements like text fields and multi-select checkboxes. Centralized font settings and padding for easier maintenance. Implemented Factory design pattern to serialize the user interface using Fluent design, significantly reducing the codebase size.',
            style: TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }

  bottomWidgetShrey() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
              child: Text(
            "Instituted UI framework, structured color classes, and app aesthetics. Crafted home screen with smooth navigation between forms. Developed landing pages for Android and web. Ensured code consistency across branches, resolved conflicts, and optimized UI for various screen sizes.",
            style: TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
