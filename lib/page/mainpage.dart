import 'package:flutter/material.dart';
import 'package:kiit_connect/drawer/devdrawer.dart';
import 'package:kiit_connect/theme/neo_box.dart';

import '../drawer/drawer.dart';
import '../theme/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openendDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _openstartDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: SideDrawer(),
      endDrawer: Devdrawer(),
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: NeoBox(
                    child: IconButton(
                        icon: Icon(Icons.menu), onPressed: _openstartDrawer),
                  ),
                ),
                Text(
                  "WELCOME",
                  style: TextStyle(letterSpacing: 2, fontSize: 17),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: NeoBox(
                    child: IconButton(
                      icon: Icon(Icons.menu_open_outlined),
                      onPressed: _openendDrawer,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  height: size.height * 0.2,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.2 - 27,
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hi Student",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/travel.png",
                                    fit: BoxFit.cover,
                                    height: 35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: mainColor.withOpacity(0.23))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: TextField(
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                          color: mainColor.withOpacity(0.5))),
                                )),
                                Icon(Icons.search,
                                    color: mainColor.withOpacity(0.5)),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
