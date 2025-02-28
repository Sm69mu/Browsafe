import 'package:get/get.dart';

class WebScreenController extends GetxController {
  final Rx<int> loadingpercentage = 0.obs;
  final Rx<String> currentUrl = "".obs;
  final Rx<String> url = "".obs;

  void finishedloading(String url) {
    currentUrl.value = url;
  }

  bool isURL(String text) {
    final urlPattern = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?'
      r'[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}'
      r'(:[0-9]{1,5})?(\/.*)?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(text.trim());
  }
}
