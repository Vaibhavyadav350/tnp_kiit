import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiit_connect/user/member/basicprofile.dart';

import '../theme/neo_box.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? photoUrl = user?.photoURL;
    return Drawer(
        width: 250,
        child: SizedBox(
          height: 100,
          child: NeoBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    if (photoUrl != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(photoUrl),
                        radius: 45.0,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(user?.displayName ?? 'Guest',
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const BasicProfile()),
                  );
                },
                child: const NeoBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Create Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )
                  ],
                )),
              ),
              const SizedBox(
                height: 15,
              ),
              const NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Internship",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.auto_graph,
                    color: Colors.purpleAccent,
                  )
                ],
              )),
              const SizedBox(
                height: 15,
              ),
              const NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "About TNP",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.graphic_eq,
                    color: Colors.green,
                  )
                ],
              )),
              const SizedBox(
                height: 15,
              ),
              const NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Gallery",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.music_note,
                    color: Colors.pinkAccent,
                  )
                ],
              )),
              const SizedBox(
                height: 15,
              ),
              const NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.call,
                    color: Colors.blue,
                  )
                ],
              )),

              const SizedBox(
                height: 15,
              ),
              const NeoBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Logout",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.grey,
                  )
                ],
              )),
            ],
          )),
        ));
  }
}
