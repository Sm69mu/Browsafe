import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mydialogs {
  static success({required String msg}) {
    Get.snackbar("Success", msg);
  }

  static error({required String err}) {
    Get.snackbar("Error:", err,backgroundColor: Colors.redAccent.withOpacity(0.3));
  }

  static info({required String message}) {
    Get.snackbar("Info", message);
  }
}
