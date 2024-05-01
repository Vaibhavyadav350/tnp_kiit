import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/theme/colors.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import '../theme/utils/text/neo_box.dart';

class Notifi extends StatefulWidget {
  const Notifi({super.key});

  @override
  State<Notifi> createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? photoUrl = user?.photoURL;
    return Drawer(
        width: 300,
        child: SizedBox(
          height: 100,
          child: NeoBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    smallSpacing(),
                    NeoBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Approved ",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      ],
                    )),
                  ],
                ),
              ),

            ],
          )),
        ));
  }
}
