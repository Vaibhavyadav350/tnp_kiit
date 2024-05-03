import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/home/HomePage.dart';

import '../../navigation/bottomapp.dart';

class AdminPageLogin extends StatefulWidget{
  @override
  State<AdminPageLogin> createState() => _AdminPageLoginState();
}

class _AdminPageLoginState extends State<AdminPageLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/splash/profile.svg",
                fit: BoxFit.cover),
            const SizedBox(
              height: 20,
            ),
            const Text("Admin Page",style:TextStyle(color: Colors.blue,
                fontWeight:FontWeight.bold,
                fontSize: 40)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        hintText: "Enter Username",
                        labelText: "UserName"
                    ),
                    style: const TextStyle(
                        fontSize: 25
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(
                        fontSize: 25
                    ),
                    decoration: const InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password"
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    child: Text("Login"),
                    style:TextButton.styleFrom(minimumSize: Size(150,50)),
                    onPressed: (){
                      String username = usernameController.text;
                      String password = passwordController.text;
                      if (username == "Youdontknowtheusername123" && password == "V12v35b*@sujb@28394ub") {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  MyBottomNavBar()),
                        );
                      } else {
                        // Show error message or handle invalid login
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Invalid Credentials"),
                              content: Text("Please enter valid username and password."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
