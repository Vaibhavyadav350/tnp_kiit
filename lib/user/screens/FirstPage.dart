import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                height: 300,
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
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "  Placements",
                style: TextStyle(
                    color: kiitgreen,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 40,),
          Center(
            child: SizedBox(
              height: 50,width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  minimumSize: const Size(300, 60), //////// HERE
                ),
                onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
