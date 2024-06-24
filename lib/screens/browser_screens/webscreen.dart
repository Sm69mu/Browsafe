import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";

class WebScreen extends StatefulWidget {
  final String url;
  WebScreen({super.key, required this.url});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late final WebViewController controller;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("webview"),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingpercentage < 100)
            LinearProgressIndicator(
              value: loadingpercentage / 100.0,
            )
        ],
      ),
    );
  }
}
