import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

          Image.asset("assets/vector/Maintenance-cuate.png"),
        ]

        ),
      ),
    );
  }
}
