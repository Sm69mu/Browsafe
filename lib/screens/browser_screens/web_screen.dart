import 'dart:async';

import 'package:Browsafe/controllers/webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:webview_flutter/webview_flutter.dart";

import '../../controllers/vpn_controller.dart';
import '../../services/vpn_engine.dart';
import '../../widgets/more_widget.dart';
import '../vpn_screen/vpn_screen.dart';

class WebScreen extends StatefulWidget {
  final String url;
  WebScreen({super.key, required this.url});
  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final _controller = Get.put(HomeController());
  final _webvcontroller = Get.put(WebvController());
  final TextEditingController SearchController = TextEditingController();
  late final WebViewController controller;
  late var weburl;
  final currentUrl = ValueNotifier<String>('');

  Future<bool> exitApp(BuildContext context) async {
    if (await controller.canGoBack()) {
      print("onwill goback");
      controller.goBack();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse(widget.url));

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
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: BeveledRectangleBorder(),
                        context: context,
                        builder: (BuildContext context) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: HomeScreen());
                        });
                  },
                  icon: Obx(
                    () => Icon(
                      _controller.vpnstate.value == VpnEngine.vpnConnected
                          ? Icons.vpn_key_outlined
                          : Icons.vpn_key_off_outlined,
                    ),
                  ),
                ),
                MoreWidget()
              ],
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.home_outlined)),
              title: SizedBox(
                height: 45,
                child: TextField(
                    controller: SearchController,
                    onSubmitted: (value) {
                      weburl = Uri.parse(value);
                      if (weburl.scheme.isEmpty) {
                        weburl =
                            Uri.parse("https://www.google.com/search?q=$value");
                      }
                      controller.loadRequest(weburl);
                      widget.url == weburl;
                    },
                    decoration: InputDecoration(
                      hintText: widget.url,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )),
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
