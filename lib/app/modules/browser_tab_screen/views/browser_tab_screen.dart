import 'package:Browsafe/app/modules/home_screen/views/home_screen.dart';
import 'package:Browsafe/app/modules/web_screen/views/web_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/browser_tab_controller.dart';

class BrowserTabviewScreen extends StatelessWidget {
  final _tabController = Get.put(BrowserTabController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 76, 10, 87), Colors.black],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Open Tabs'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(() => BrowserHomeScreen()),
            ),
          ],
        ),
        body: Obx(() => GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemCount: _tabController.tabs.length,
              itemBuilder: (context, index) {
                final tab = _tabController.tabs[index];

                return InkWell(
                  onTap: () {
                    Get.to(() => WebScreen(url: tab.url));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: tab.controller != null
                                  ? IgnorePointer(
                                      child: WebViewWidget(
                                          controller: tab.controller!),
                                    )
                                  : Center(child: CircularProgressIndicator())),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12))),
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tab.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close, size: 16),
                                onPressed: () => _tabController.closeTab(index),
                                color: Colors.white54,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
