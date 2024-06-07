import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    const kPrimaryColor = Colors.purple;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor, padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            Container(decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(100)
            ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.arrow_forward_ios),
                )),
          ],
        ),
      ),
    );
  }
}