// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:google_fonts/google_fonts.dart';
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
            color: Colors.transparent,
            topCardHeight: 350,
            bottomCardHeight: 270,
            topCardWidget: topWidgetAnirudh(),
            bottomCardWidget: bottomWidgetAnirudh(),
          ),
          smallSpacing(),
          FlutterSlimyCard(
            color: Colors.transparent,
            topCardHeight: 350,
            bottomCardHeight: 270,
            topCardWidget: topWidgetShrey(),
            bottomCardWidget: bottomWidgetShrey(),
          ),
          smallSpacing(),
          FlutterSlimyCard(
            color: Colors.transparent,
            topCardHeight: 350,
            bottomCardHeight: 270,
            topCardWidget: topWidgetVaibhav(),
            bottomCardWidget: bottomWidgetVaibhav(),
          ),
          smallSpacing(),
          smallSpacing()
        ],
      ),
    ));
  }


  topWidgetAnirudh() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(15.0)),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Stack(alignment: Alignment.center,
             children: [
              
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    color: greenHighlight,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                height: 100,
                child: ClipOval(
                  child: Container(
                    child: Image(image: AssetImage('assets/images/ani.png')),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),

            Stack(alignment: Alignment.topCenter,
            children: [
              Positioned(
                child: Text(
                'Developer',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 51.0,
                  color: Colors.white24
                ),
                softWrap: false,

              )
              ),
              Text(
              'Anirudh Sharma',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            ],)
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/Minecraftian14'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/github.png', height: 40),
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
                        Image.asset('assets/images/linkedin.png', height: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.instagram.com/minecraftian14as/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/ig.png', height: 30),
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
      decoration: BoxDecoration(
          color: Colors.teal.shade900, borderRadius: BorderRadius.circular(15.0)),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Stack(alignment: Alignment.center,
             children: [
              
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    color: greenHighlight,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                height: 100,
                child: ClipOval(
                  child: Container(
                    child: Image(image: AssetImage('assets/images/shrey.png')),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),

            Stack(alignment: Alignment.topCenter,
            children: [
              Positioned(
                child: Text(
                'Brewer',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 70.0,
                  color: Colors.white24
                ),
                softWrap: false,

              )
              ),
              Text(
              'Shreya Shashank',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            ],)
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/Ayushh1023'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/github.png', height: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/ssha512/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child:
                        Image.asset('assets/images/linkedin.png', height: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.instagram.com/shawshank_shrey2310/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/ig.png', height: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




  topWidgetVaibhav() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.brown.shade900, borderRadius: BorderRadius.circular(15.0)),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Stack(alignment: Alignment.center,
             children: [
              
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    color: greenHighlight,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                height: 100,
                child: ClipOval(
                  child: Container(
                    child: Image(image: AssetImage('assets/images/vaibhav.png')),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),

            Stack(alignment: Alignment.topCenter,
            children: [
              Positioned(
                child: Text(
                'Lead',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 70.0,
                  color: Colors.white24
                ),
                softWrap: false,

              )
              ),
              Text(
              'Vaibhav Yadav',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            ],)
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/Vaibhavyadav350'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/github.png', height: 40),
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
                        Image.asset('assets/images/linkedin.png', height: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://www.instagram.com/iamvaibhav.dev/'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset('assets/images/ig.png', height: 30),
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
          Expanded(
            child: Container(
              color: Colors.black26, // Background color
              padding: EdgeInsets.all(10), // Adjust padding as needed
              child: Flexible(
                child: Text(
                  'Abstracted UI code for reusability, creating classes for elements like text fields and multi-select checkboxes. Centralized font settings and padding for easier maintenance. Implemented Factory design pattern to serialize the user interface using Fluent design, significantly reducing the codebase size.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
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
