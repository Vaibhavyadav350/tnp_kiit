import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:kiit_connect/theme/colors.dart';

class Developers extends StatelessWidget {
  const Developers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            children: <Widget>[

              smallSpacing(),
              FlutterSlimyCard(
                color: Colors.green,
                topCardHeight: 160,
                bottomCardHeight: 120,
                topCardWidget: topWidgetAnirudh(),
                bottomCardWidget: bottomWidgetAnirudh(),
              ),
              smallSpacing(),
              FlutterSlimyCard(
                color: Colors.blue,
                topCardHeight: 160,
                bottomCardHeight: 120,
                topCardWidget: topWidgetShrey(),
                bottomCardWidget: bottomWidgetShrey(),
              ),
              smallSpacing(),
              FlutterSlimyCard(
                color: Colors.red,
                topCardHeight: 160,
                bottomCardHeight: 120,
                topCardWidget: topWidgetVaibhav(),
                bottomCardWidget: bottomWidgetVaibhav(),
              ),
              smallSpacing(),
              smallSpacing()
            ],
          ),
        ));
  }



  topWidgetVaibhav() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(height: 75, child: Image(image: AssetImage('assets/run_horse.png'))),
            SizedBox(
              height: 5,
            ),
            Text(
              'Vaibhav Yadav',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  topWidgetAnirudh() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(height: 75, child: Image(image: AssetImage('assets/run_horse.png'))),
            SizedBox(
              height: 5,
            ),
            Text(
              'Anirudh Sharma',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  topWidgetShrey() {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(height: 75, child: Image(image: AssetImage('assets/run_horse.png'))),
            SizedBox(
              height: 5,
            ),
            Text(
              'Shreya Shanshank',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  bottomWidgetVaibhav() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
              child: Text(
                "Lead developer responsible for spearheading the implementation of innovative features,"
                    " designing the database architecture, and enhancing user interaction within the project.",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  bottomWidgetAnirudh() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
              child: Text(
                'Developer specialized in optimizing code performance, constructing dynamic builders for CRUD operations,'
                    ' and improving the overall system efficiency.',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  bottomWidgetShrey() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
              child: Text(
                'Developer focused on translating design concepts into'
                    ' captivating UI elements, thereby enriching user experience and ensuring intuitive interface interaction.',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  
}
