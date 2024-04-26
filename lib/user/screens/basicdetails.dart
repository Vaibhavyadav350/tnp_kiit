import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/textfield.dart';

import '../../theme/colors.dart';

class BasicDetails extends StatefulWidget {
  const BasicDetails({super.key});

  @override
  _BasicDetailsState createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/tnpkiit.png",
                fit: BoxFit.cover,
                height: 200,
              ),
              const Text("Basic Information",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
              const SizedBox(height: 16),
              customTextField(hintText: 'Name'),
              const SizedBox(height: 16),
              customTextField(hintText: 'Address'),
              const SizedBox(height: 16),
              customTextField(hintText: 'Phone Number'),
              const SizedBox(height: 16),
              customTextField(hintText: 'Personal Email'),
              const SizedBox(height: 64),
              Center(
                child: SizedBox(
                  height: 50,width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minimumSize: const Size(300, 60), //////// HERE
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Proceed',style: TextStyle(color: Colors.black),),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}