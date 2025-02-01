import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future myAlertDialog(String title, dynamic content, VoidCallback onClick, VoidCallback cancelClick) {
  return Get.dialog(
    AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: cancelClick,
          child: const Text("Cancel"),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 132, 19, 152),
          ),
          onPressed: onClick,
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
