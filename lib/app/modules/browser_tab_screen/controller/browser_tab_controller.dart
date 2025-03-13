import 'package:Browsafe/app/data/models/browsertab_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/services/local_storage/browser_tabs_storage.dart';

class BrowserTabController extends GetxController {
  final tabs = <BrowserTab>[].obs;
  final activeTabIndex = 0.obs;
  final wecontroller = WebViewController();

  @override
  void onInit() {
    super.onInit();
    _loadCachedTabs();
  }

  void addNewTab(String? url) {
    final newTab = BrowserTab(
      id: const Uuid().v4(),
      title: 'New Tab',
      url: url!,
    );
    // Initialize WebViewController for the new tab
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            updateTabTitle(newTab.id);
          },
        ),
      );
    newTab.controller = controller;
    tabs.add(newTab);
    _cacheTabs();

    // Set the new tab as active
    setActiveTab(tabs.length - 1);
  }

  void setActiveTab(int index) {
    if (index >= 0 && index < tabs.length) {
      activeTabIndex.value = index;
    }
  }

  Future<void> _loadCachedTabs() async {
    final cachedTabs = TabStorage.loadTabs();
    for (var tab in cachedTabs) {
      // Recreate WebViewController for each tab
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(tab.url))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              updateTabTitle(tab.id);
            },
          ),
        );
      tab.controller = controller;
    }
    tabs.assignAll(cachedTabs);
  }

  Future<void> _cacheTabs() async {
    await TabStorage.saveTabs(tabs);
  }

  Future<void> updateTabTitle(String tabId) async {
    final index = tabs.indexWhere((tab) => tab.id == tabId);
    if (index != -1) {
      final title = await tabs[index].controller?.getTitle() ?? 'New Tab';
      tabs[index] = BrowserTab(
        id: tabs[index].id,
        title: title,
        url: tabs[index].url,
        controller: tabs[index].controller,
        isActive: index == activeTabIndex.value,
      );
    }
  }

  void closeTab(int index) {
    if (index >= 0 && index < tabs.length) {
      tabs.removeAt(index);
      _cacheTabs();

      if (tabs.isEmpty) {
        Get.back();
      } else if (activeTabIndex.value >= tabs.length) {
        setActiveTab(tabs.length - 1);
      }
    }
  }
}
