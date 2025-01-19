import 'package:Browsafe/app/modules/web_screen/controllers/webview_controller.dart';
import 'package:Browsafe/app/widgets/more_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WebScreen extends StatefulWidget {
  String url;
  //TODO: notice here
  WebScreen({super.key, required this.url});
  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final _webvcontroller = Get.put(WebvController());
  final TextEditingController SearchController = TextEditingController();
  InAppWebViewController? inAppWebViewController;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewSettings settings = InAppWebViewSettings(
      javaScriptCanOpenWindowsAutomatically: true,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.purple),
      onRefresh: () async {
        inAppWebViewController!.reload();
      },
    );
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
          if (await inAppWebViewController!.canGoBack()) {
            inAppWebViewController!
              ..goBack()
              ..clearHistory();
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
                  controller: inAppWebViewController!,
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
                      keyboardType: TextInputType.url,
                      controller: SearchController,
                      onSubmitted: (value) {
                        var weburl = WebUri(value);
                        if (weburl.scheme.isEmpty) {
                          weburl =
                              WebUri("https://www.google.com/search?q=$value");
                        }
                        inAppWebViewController?.loadUrl(
                            urlRequest: URLRequest(url: weburl));
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
              InAppWebView(
                key: webViewKey,
                initialSettings: settings,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  inAppWebViewController = controller;
                },
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                onLoadStart: (controller, url) {
                  widget.url = url.toString();
                  SearchController.text = url.toString();
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  _webvcontroller.loadingpercentage.value = progress;
                  if (_webvcontroller.loadingpercentage.value == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                },
                onReceivedError: (controller, request, error) {
                  pullToRefreshController?.endRefreshing();
                },
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
