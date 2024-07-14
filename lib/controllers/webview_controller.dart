import 'package:get/get.dart';

class WebvController extends GetxController {
  final Rx<int> loadingpercentage = 0.obs;
  final Rx<String> currentUrl = "".obs;

   void finishedloading(String url) {
    currentUrl.value = url;
  }
}
