import 'dart:developer';

import 'package:Browsafe/controllers/webview_controller.dart';
import 'package:Browsafe/widgets/more_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:webview_flutter/webview_flutter.dart";

class WebScreen extends StatefulWidget {
  final String url;
  WebScreen({super.key, required this.url});
  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final _webvcontroller = Get.put(WebvController());
  final TextEditingController SearchController = TextEditingController();
  late final WebViewController controller;
  late var weburl;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..currentUrl().then((url) {
        _webvcontroller.currentUrl.value = url.toString();
        log(_webvcontroller.currentUrl.value);
      });

    controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          _webvcontroller.loadingpercentage.value = 0;
        },
        onProgress: (progress) {
          _webvcontroller.loadingpercentage.value = progress;
        },
        onPageFinished: (url) {
          _webvcontroller.loadingpercentage.value = 100;
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //app background color
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (await controller.canGoBack()) {
            controller.goBack();
            controller.clearCache();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.numbers_outlined)),
                Morewebwidget(
                  controller: controller,
                )
              ],
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.home_outlined)),
              title: SizedBox(
                height: 45,
                child: Obx(
                  () => TextField(
                      controller: SearchController,
                      onSubmitted: (value) {
                        weburl = Uri.parse(value);
                        if (weburl.scheme.isEmpty) {
                          weburl = Uri.parse(
                              "https://www.google.com/search?q=$value");
                        }
                        controller.loadRequest(weburl);
                        controller.currentUrl().then((url) {
                          _webvcontroller.currentUrl.value = url.toString();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: _webvcontroller.currentUrl.value,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ),
              )),
          body: Stack(
            children: [
              WebViewWidget(
                controller: controller,
              ),
              Obx(() => _webvcontroller.loadingpercentage.value < 100
                  ? LinearProgressIndicator(
                      value: _webvcontroller.loadingpercentage.value / 100.0,
                    )
                  : SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }
}
