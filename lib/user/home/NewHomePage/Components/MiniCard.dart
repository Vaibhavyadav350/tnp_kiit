import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiit_connect/user/home/utils/device_variables.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget miniCard(
    {required BuildContext context,
    double bottomPos = -40,
    required String title,
    double fontSize = 22.0,
    required String imgPath,
    required double height,
    required double width,
    required double rightPos,
    double imgwidth = 180,
    required String hexColorCode,
    required String toastMessage,
    Widget? nextRoute}) {

  

  final deviceVariables = DeviceVariables.fromBuildContext(context);
  double testW = 411.00;
  double testInvW = 1 / testW;
  double devW = deviceVariables.screenWidth;
  double adjust = testInvW * devW;

  width *= adjust;

  // final List<String> coolors = [
  //   'DBCFC3',
  //   'D3E3D6',
  //   'FDBC96',
  //   'DAC2CF',
  //   'E0C9BC',
  //   'C1D7FF',
  //   "C4E7FF",
  //   "CAE7DC",
  //   "B6E4E9"
  // ];

  // hexColorCode ??= (coolors..shuffle()).first; 
  Color backgroundColor = Color(int.parse('0xFF$hexColorCode'));
  Color textColor = Color(int.parse('0xFF240750'));

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 20,
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                    color: textColor,
                  ),
                ),
              ),
              Positioned(
                bottom: bottomPos,
                right: rightPos,
                child: Image.asset(
                  imgPath,
                  width: imgwidth,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              ),
              if (nextRoute != null)
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => nextRoute));
                  },
                  onLongPress: () {
                    Fluttertoast.showToast(
                      msg: toastMessage,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16.0,
                    );
                  },
                  behavior: HitTestBehavior.translucent,
                ))
            ],
          ),
        ),
      ),
    ),
  );
}
