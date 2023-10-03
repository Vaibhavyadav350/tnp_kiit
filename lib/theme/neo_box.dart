import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';

class NeoBox extends StatelessWidget {
  final child;

  const NeoBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.all(9),
        child: child,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 15,
                  offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
            ]),
      ),
    );
  }
}

class MatTextField extends StatelessWidget {
  final label;
  final controller;
  final maxLines;
  final hintText;

  MatTextField({
    Key? key,
    this.label,
    this.controller,
    this.maxLines = 1,
    this.hintText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          padWrap(Text(label, style: textAnnotation(context))),
          padWrap(boxWrap(TextFormField(
            controller: controller,
            decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: textAnnotation(context, color: Theme
                    .of(context)
                    .primaryColor
                    .withAlpha(80))),
            style: textAnnotation(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter ${label.toLowerCase()}";
              }
              return null;
            },
            maxLines: maxLines,
          )))
        ],
      ),
    );
  }
}


class MatTextButton extends StatelessWidget {
  final text;
  final onPressed;
  final icon;

  MatTextButton({
    Key? key,
    this.text,
    this.onPressed,
    this.icon = Icons.arrow_forward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: padWrap(TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: boxWrap(moveCenter([
          Text(text, style: textAnnotation(context)),
          Icon(icon, color: Theme
              .of(context)
              .primaryColor),
        ]), color: greenHighlight),
      )),
    );
  }
}

