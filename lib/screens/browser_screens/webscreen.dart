import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:webview_flutter/webview_flutter.dart";

import '../../widgets/more_widget.dart';
import '../home_screen.dart';

class WebScreen extends StatefulWidget {
  final String url;
  WebScreen({super.key, required this.url});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final TextEditingController SearchController = TextEditingController();
  late final WebViewController controller;
  late var weburl;
  var loadingpercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse(widget.url));

    controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingpercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingpercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingpercentage = 100;
          });
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("SnackBar", onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        controller.goBack();
      },
      child: Container(
        decoration: BoxDecoration(
            //app background color
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
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
                    icon: Icon(Icons.vpn_key_outlined)),
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
              if (loadingpercentage < 100)
                LinearProgressIndicator(
                  value: loadingpercentage / 100.0,
                )
            ],
          ),
        ),
      ),
    );
  }
}
