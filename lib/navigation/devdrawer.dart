import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import '../theme/utils/text/neo_box.dart';

class Devdrawer extends StatelessWidget {
  const Devdrawer({super.key});

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
                      "Status",
                      style: TextStyle(fontSize: 30),
                    ),
                    Row(
                      children: [
                        if (photoUrl != null)
                          NeoBox(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(photoUrl),
                              radius: 30.0,
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        NeoBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Approved ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              NeoBox(
                  child: GestureDetector(
                    onTap: (){
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(builder: (context) => DataScreen()),
                      // );
                    },
                    child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Text(
                      "Your Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )
                ],
              ),
                  )),
              SizedBox(
                height: 15,
              ),
              NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "ADD POST",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.blue,
                  )
                ],
              )),
              SizedBox(
                height: 15,
              ),
              NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Selected Companies",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.auto_graph,
                    color: Colors.purpleAccent,
                  )
                ],
              )),
              SizedBox(
                height: 15,
              ),
              NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Developers",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.graphic_eq,
                    color: Colors.green,
                  )
                ],
              )),
            ],
          )),
        ));
  }
}
