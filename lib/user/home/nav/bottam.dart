import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 350,
              width: 1000,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F)
                  ]
                ),
                image: DecorationImage(
                  image: AssetImage("assets/vector/Doodle.png",)
                )
              ),
              child: Expanded(
                  child: Stack(
                    children: [
                      Image.asset(alignment: Alignment.topCenter,
                          fit: BoxFit.fitWidth,
                          width: 300,"assets/vector/Instant information-cuate.png"),

                    ],
                  )),
            ),
          ),

        ],
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
