import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/neo_box.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({Key? key}) : super(key: key);

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  TextEditingController _resumeController = TextEditingController();
  TextEditingController _githubController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _othersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeoBox(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            // Handle back button pressed
                          },
                        ),
                      ),
                    ),
                    const Text(
                      "Profile Links",
                      style: TextStyle(letterSpacing: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [

                      ],),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeoBox(
                        child:
                           Icon(Icons.add),

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    NeoBox(
                      child: TextFormField(
                        controller: _resumeController,
                        decoration: const InputDecoration(labelText: 'Resume Link', border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Resume Link';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    NeoBox(
                      child: TextFormField(
                        controller: _githubController,
                        decoration: const InputDecoration(labelText: 'Github Link', border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Github Link';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    NeoBox(
                      child: TextFormField(
                        controller: _linkedinController,
                        decoration: const InputDecoration(labelText: 'Linkedin Id', border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Linkedin Link';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    NeoBox(
                      child: TextFormField(
                        controller: _othersController,
                        decoration: const InputDecoration(labelText: 'Others', border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
