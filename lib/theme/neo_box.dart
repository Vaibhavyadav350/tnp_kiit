import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeoBox extends StatelessWidget {
  final child;
  const NeoBox({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Container(
        padding: EdgeInsets.all(9),
        child: child,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade500,blurRadius: 15,offset: Offset(5,5)),
              BoxShadow(color: Colors.white,blurRadius: 15,offset: Offset(-5,-5))
            ]

        ),
      ),
    );
  }
}
