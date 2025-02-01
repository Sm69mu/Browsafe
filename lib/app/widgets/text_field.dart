import 'package:flutter/material.dart';

Widget customTextField(
    {required TextEditingController controller,
    required String hintText,
    final bool? isIcon,
    required IconData icon,
    required TextInputType keyboardType,
    required bool obscureText}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: isIcon! ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
