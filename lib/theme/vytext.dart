import 'package:flutter/material.dart';

Widget VyText(TextEditingController controller, String label, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
         labelStyle: const TextStyle(color: Colors.white),
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        fillColor: Colors.green.withOpacity(0.1),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    ),
  );
}