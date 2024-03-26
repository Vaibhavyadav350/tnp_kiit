import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';

class GreenDrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIconIndex = -1; // -1 means no icon is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 100,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildIcon(0, Icons.home),
              buildIcon(1, Icons.search),
              buildIcon(2, Icons.favorite),
              buildIcon(3, Icons.notifications),
              buildIcon(4, Icons.person),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon(int index, IconData icon) {
    bool isSelected = selectedIconIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIconIndex = index;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            transform: isSelected
                ? Matrix4.translationValues(0.0, -30.0, 0.0)
                : Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ),
          SizedBox(height: 10,),
          if (isSelected) GreenDrip(),
        ],
      ),
    );
  }
}


