import 'package:flutter/material.dart';

Widget VyText(TextEditingController controller, String label, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
         labelStyle: TextStyle(color: Colors.white),
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        fillColor: Colors.green.withOpacity(0.1),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    ),
  );
}