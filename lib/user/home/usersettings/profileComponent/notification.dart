import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../theme/maintenance.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("assets/vector/Push notifications-amico.png"),
            Text(
              "No Notification Yet!",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 22.0,
                color: Colors.purple,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
