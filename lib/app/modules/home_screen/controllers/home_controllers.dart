import 'dart:convert';

import 'package:Browsafe/app/data/models/news_model.dart';
import 'package:Browsafe/app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/controllers/preferenec_controller.dart';
import '../../../constants/helpers/snackbars.dart';
import '../../../data/models/favourite_sites.dart';
import '../../../data/services/local_storage/favourite_sites_storage.dart';
import '../../../data/services/local_storage/vpnlist_storage.dart';
import '../../../data/models/vpn.dart';
import '../../../data/models/vpn_config.dart';
import '../../../data/services/news_api/news_api.dart';
import '../../../data/services/vpn_engine/vpn_engine.dart';
import '../../../widgets/alert_dialogbox.dart';

class HomeController extends GetxController {
  final _userPrefsController = Get.put(UserPreferencesController());

  @override
  void onInit() async {
    super.onInit();
    loadFavorites();
    isNewsEnabled.value = _userPrefsController.newsState;
    if (isNewsEnabled.value) {
      GetNews();
    }
  }

  @override
  void onClose() {
    urlController.dispose();
    titleController.dispose();
    super.onClose();
  }

  //------VPN--------------------

  final Rx<Vpn> vpninfo = vpnProfilesStorage.vpn.obs;
  final vpnstate = VpnEngine.vpnDisconnected.obs;
  final RxBool vpnswitcch = false.obs;
  void connectToVpn() {
    if (vpninfo.value.openVPNConfigDataBase64.isEmpty) {
      SnackBars.info(message: "First Select a Location ");
      return;
    }
    if (vpnstate.value == VpnEngine.vpnDisconnected) {
      final cryptdata =
          Base64Decoder().convert(vpninfo.value.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(cryptdata);
      final vpnConfig = VpnConfig(
        country: vpninfo.value.countrylong,
        username: 'vpn',
        password: 'vpn',
        config: config,
      );
      VpnEngine.startVpn(vpnConfig);
      vpnswitcch.value = true;
    } else {
      VpnEngine.stopVpn();
      vpnswitcch.value = false;
      SnackBars.success(msg: "Vpn disconnected");
    }
  }

  



  //------Favorite Sites--------------------

  final RxList<FavoriteSite> favoriteSites = <FavoriteSite>[].obs;
  Rx<String> siteTitle = "".obs;
  final TextEditingController urlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  void loadFavorites() {
    final sites = FavoriteSitesStorage.getAllFavorites();
    favoriteSites.assignAll(sites);
  }

  onAddClick() async {
    await myAlertDialog(
        "Enter Your URL",
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customTextField(
                isIcon: false,
                controller: urlController,
                hintText: "Enter URL ",
                icon: Icons.abc_outlined,
                keyboardType: TextInputType.url,
                obscureText: false),
            customTextField(
                isIcon: false,
                controller: titleController,
                hintText: "Enter Title",
                icon: Icons.abc_outlined,
                keyboardType: TextInputType.text,
                obscureText: false),
          ],
        ), () {
      onAddFavorite(urlController.text, titleController.text).then((value) {
        clearTextFields();
        Get.back();
      });
    }, () {
      cancelClick();
    });
  }

  clearTextFields() {
    urlController.clear();
    titleController.clear();
  }

  cancelClick() {
    clearTextFields();
    Get.back();
  }

  Future<void> onAddFavorite(String url, String title) async {
    final site = FavoriteSite(url: url, title: title);
    await FavoriteSitesStorage.addFavorite(site);
    favoriteSites.add(site);
  }

  Future<void> removeFavorite(int index) async {
    await FavoriteSitesStorage.removeFavorite(index);
    favoriteSites.removeAt(index);
  }

//TODO: complete the edit site function
// complete the edit site function

  Future<void> editFavorite(int index, String newUrl, String newTitle) async {
    //final site = favoriteSites[index];
    final updatedSite = FavoriteSite(url: newUrl, title: newTitle);
    await FavoriteSitesStorage.editFavorite(index, updatedSite);
    favoriteSites[index] = updatedSite;
  }

  //----------------------------------news api--------------------------------

  final RxList<Map<String, String>> news = <Map<String, String>>[
    {
      'title': '',
      'description': '',
      'url': '',
      'urlToImage': '',
    },
  ].obs;

  final _newsRepo = Get.put(NewsApiServices());
  Rx<NewsResponse?> NewsApiResponse = Rx(null);
  var isLoading = false.obs;

  GetNews() async {
    isLoading.value = true;
    await GetNewsResponse();
    isLoading.value = false;
  }

  final RxBool isNewsEnabled = false.obs;
  final RxString newsToggleString = "".obs;

  void toggleNews() async {
    isNewsEnabled.value = !isNewsEnabled.value;

    // Persist state change
    await _userPrefsController.changeNewsState(isNewsEnabled.value);

    if (isNewsEnabled.value) {
      newsToggleString.value = "Off";
      GetNews();
    } else {
      newsToggleString.value = "On";
      news.clear();
    }
  }

  Future GetNewsResponse() async {
    try {
      final response = await _newsRepo.getEverything('technology', 1);
      if (response.statusCode == 200) {
        final rawJson = jsonDecode(response.body);
        final results = NewsResponse.fromJson(rawJson);

        if (results.status == "ok") {
          news.clear();
          news.addAll(results.articles!
              .map((article) => {
                    'title': article.title ?? "",
                    'description': article.description ?? "",
                    'url': article.url ?? "",
                    'urlToImage': article.urlToImage ?? "",
                  })
              .toList());
        } else {
          SnackBars.error(err: 'Failed to load news');
        }
      } else {
        SnackBars.error(err: 'Failed to load news');
      }
    } catch (e) {
      SnackBars.error(err: 'Error loading news: ${e.toString()}');
    }
  }
}
