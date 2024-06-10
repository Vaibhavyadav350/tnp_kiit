import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiit_connect/theme/loading.dart';
import 'package:lottie/lottie.dart';

import '../NewHomePage/NewHomePage.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:_isLoading
          ? Center(child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset("assets/vector/shimmer.json"),
                Lottie.asset("assets/vector/shimmer.json"),
              ],
            ),
          ))
      :SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
                    image: DecorationImage(
                        image: AssetImage(
                      "assets/vector/Doodle.png",
                    ))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      bottom: 40,
                      child: SvgPicture.asset(
                          fit: BoxFit.fitWidth,
                          width: 230,
                          "assets/vector/greeenfreepik--Character--inject-205.svg"),
                    ),
                    const Positioned(
                      right: 10,
                      top: 130,
                      child: Text(
                        "Welcome\n TnP Developer",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const NewHomePage(),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
