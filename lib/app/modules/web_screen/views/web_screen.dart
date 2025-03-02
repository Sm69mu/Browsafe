import 'dart:developer';

import 'package:Browsafe/app/modules/web_screen/controllers/webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/assets/colors.dart';

class WebScreen extends StatefulWidget {
  String url;
  //TODO: notice here
  WebScreen({super.key, required this.url});
  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late WebViewController webController;
  late TextEditingController searchController;
  final getController = Get.put(WebScreenController());

  void searchOrQueary() {
    String queary = searchController.text.trim();
    Uri.tryParse(queary);
    bool isUri = Uri.parse(queary).isAbsolute;
    if (isUri) {
      webController.loadRequest(Uri.parse(queary));
    } else {
      String searchUrl = "https://www.google.com/search?q=$queary";
      webController.loadRequest(Uri.parse(searchUrl));
    }
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.url);
    webController = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          searchController.text = url;
          getController.loadingpercentage.value = 0;
        },
        onProgress: (progress) {
          getController.loadingpercentage.value = progress;
        },
        onPageFinished: (url) {
          getController.loadingpercentage.value = 100;
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: ColorsPallets().adientPurple),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (webController.canGoBack() == true) {
            webController.goBack();
          }
          ;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Obx(
              () => buildSearchField(searchController,
                  getController.currentUrl.value, webController, (value) {
                searchOrQueary();
                webController.currentUrl().then((url) {
                  getController.currentUrl.value = url!;
                });
                searchController.clear();
                log("new url " + getController.currentUrl.value);
              }).paddingOnly(bottom: 7),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.home_outlined))
            ],
          ),
          body: Stack(children: [
            WebViewWidget(controller: webController),
            Obx(() => getController.loadingpercentage.value < 100
                ? LinearProgressIndicator(
                    minHeight: 4,
                    value: getController.loadingpercentage.value / 100,
                  )
                : SizedBox.shrink())
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: buildBottombar(
            onBackTap: () async {
              if (await webController.canGoBack()) {
                webController.goBack();
              }
            },
            onForwardTap: () async {
              if (await webController.canGoForward()) {
                webController.goForward();
              }
            },
            onNewTabTap: () {
              // Handle new tab
            },
            onAllTabsTap: () {
              // Handle all tabs
            },
            onMoreTap: () {
              // Handle more options
            },
          ),
        ),
      ),
    );
  }
}

Widget buildBottombar({
  required VoidCallback? onBackTap,
  required VoidCallback? onForwardTap,
  required VoidCallback? onNewTabTap,
  required VoidCallback? onAllTabsTap,
  required VoidCallback? onMoreTap,
}) {
  return Container(
    height: 70,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: onBackTap,
          icon: const Icon(Icons.arrow_back),
          iconSize: 27,
        ),
        IconButton(
          onPressed: onForwardTap,
          icon: const Icon(Icons.arrow_forward),
          iconSize: 27,
        ),
        IconButton(
          onPressed: onNewTabTap,
          icon: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.3),
            child: const Icon(Icons.add),
          ),
          iconSize: 27,
        ),
        IconButton(
          onPressed: onAllTabsTap,
          icon: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text("1").paddingSymmetric(vertical: 2, horizontal: 7),
          ),
          iconSize: 25,
        ),
        IconButton(
          onPressed: onMoreTap,
          icon: const Icon(Icons.more_horiz),
          iconSize: 27,
        ),
      ],
    ),
  ).paddingSymmetric(horizontal: 10);
}

Widget buildSearchField(TextEditingController searchController, String? text,
    WebViewController AppWebViewController, Function(String) onsubmmit) {
  return TextFormField(
    controller: searchController,
    keyboardType: TextInputType.url,
    maxLines: 1,
    onFieldSubmitted: onsubmmit,
    decoration: InputDecoration(
      hintText: text,
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    ),
  );
}
