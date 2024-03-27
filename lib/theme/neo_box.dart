// ignore_for_file: prefer_const_constructors

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
  final IconData? icon;
  final keyboardType;

  MatTextField({
    Key? key,
    this.label,
    this.controller,
    this.maxLines = 1,
    this.hintText = "",
    this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return padWrap(
       TextFormField(
        controller: controller,
        decoration:  InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green),
          fillColor: Colors.green.withOpacity(0.1),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
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
    // List<Widget> children = [];
    // if (icon != null) {
    //   children.addAll([
    //     Icon(icon, color: Theme.of(context).primaryColor),
    //     SizedBox(width: 8),
    //   ]);
    // }
    // children.addAll([
    //   Flexible(
    //     child: TextFormField(
    //       controller: controller,
    //       decoration:  InputDecoration(
    //         labelStyle: TextStyle(color: Colors.white),
    //         labelText: label,
    //         prefixIcon: Icon(icon, color: Colors.green),
    //         fillColor: Colors.green.withOpacity(0.1),
    //         border: OutlineInputBorder(),
    //         focusedBorder: OutlineInputBorder(
    //           borderSide: BorderSide(color: Colors.green),
    //         ),
    //       ),
    //       style: textAnnotation(context),
    //       validator: (value) {
    //         if (value == null || value.isEmpty) {
    //           return "Please enter ${label.toLowerCase()}";
    //         }
    //         return null;
    //       },
    //       maxLines: maxLines,
    //       keyboardType: keyboardType,
    //     ),
    //   ),
    // ]);
    //
    // return SizedBox(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       padWrap(Text(label, style: textAnnotation(context))),
    //       padWrap(boxWrap(Row(
    //         children: children,
    //       )))
    //     ],
    //   ),
    // );
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
    if (widget.controllers.length > 1)
      setState(() => widget.controllers.removeLast());
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
          child: boxWrap(Column(
              children: widget.controllers
                  .map((e) => SizedBox(
                    height: 35.0,
                    child: TextField(
                        controller: e,
                        style: textAnnotation(context)),
                  ))
                  .toList()))),
      SizedBox(height: 20),
      boxWrap(
          Row(
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
          height: 50.0)
    ]));
  }
}

class MatTextButton extends StatelessWidget {
  final text;
  final onPressed;
  final icon;
  final isSubmit;

  MatTextButton({
    Key? key,
    this.text,
    this.onPressed,
    this.icon = Icons.arrow_forward,
    this.isSubmit = true,
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
