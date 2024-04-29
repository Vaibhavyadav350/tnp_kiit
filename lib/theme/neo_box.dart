// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';

class NeoBox extends StatelessWidget {
  final child;

  const NeoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.all(9),
        child: child,
        decoration: BoxDecoration(
            color: darkShadow,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: darkShadow,
                  blurRadius: 15,
                  offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.black, blurRadius: 15, offset: Offset(-5, -5))
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
  final IconData? icon;
  final keyboardType;

  const MatTextField({
    super.key,
    this.label,
    this.controller,
    this.maxLines = 1,
    this.hintText = "",
    this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return padWrap(
      TextFormField(
        controller: controller,
        decoration: inputDecoration(label: label, icon: icon),
        style: textAnnotation(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter ${label.toLowerCase()}";
          }
          return null;
        },
        maxLines: maxLines,
        keyboardType: keyboardType,
      ),
    );
  }
}

class MultiTextBox extends StatefulWidget {
  final label;
  final List<TextEditingController> controllers;

  MultiTextBox({required this.label, required this.controllers, super.key}) {
    if (controllers.isEmpty) controllers.add(TextEditingController());
  }

  @override
  State<MultiTextBox> createState() => _MultiTextBoxState();
}

class _MultiTextBoxState extends State<MultiTextBox> {
  void addNewField() =>
      setState(() => widget.controllers.add(TextEditingController()));

  void removeLastField() {
    if (widget.controllers.length > 1) {
      setState(() => widget.controllers.removeLast());
    }
  }

  @override
  Widget build(BuildContext context) {
    return padWrap(Column(children: [
      SizedBox(
          width: double.infinity,
          child: Text("Add " + widget.label, style: textAnnotation(context))),
      SizedBox(height: 20),
      SizedBox(
          width: double.infinity,
          child: Column(
              children: widget.controllers
                  .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextField(
                        decoration: inputDecoration(),
                        controller: e,
                        style: textAnnotation(context)),
                  ))
                  .toList())),
      SizedBox(height: 20),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => addNewField(),
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () => removeLastField(),
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ),
      )
    ]));
  }
}

class MatTextButton extends StatelessWidget {
  final text;
  final onPressed;
  final icon;
  final isSubmit;

  const MatTextButton({
    super.key,
    this.text,
    this.onPressed,
    this.icon = Icons.arrow_forward,
    this.isSubmit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: padWrap(TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: boxWrap(
            moveCenter([
              Text(text, style: textAnnotation(context)),
              Icon(icon, color: Theme.of(context).primaryColor),
            ]),
            color: (isSubmit) ? greenHighlight : darkHighlight),
      )),
    );
  }
}
