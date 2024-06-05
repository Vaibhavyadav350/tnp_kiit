import 'package:flutter/material.dart';
import 'package:kiit_connect/user/home/NewHomePage/Components/MiniCard.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                miniCard(title: "Basic Profile", imgPath: "assets/images/photography.png", height: 200, width: 80),
                miniCard(title: "Basic Profile", imgPath: "assets/images/photography.png", height: 200, width: 80),

                ],),
                miniCard(title: "Basic Profile", imgPath: "assets/images/ux_design", height: 200, width: 100),
                miniCard(title: "Basic Profile", imgPath: "assets/images/photography.png", height: 200, width: 80),
                miniCard(title: "Basic Profile", imgPath: "assets/images/photography.png", height: 200, width: 80),

              ],

              
            ),
          ),
      ),)
    );
  }
}