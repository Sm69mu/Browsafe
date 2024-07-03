import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  NativeAd? nativeAd;
  RxBool nativeAdIsLoaded = false.obs;
  final String nativeadUnit = "ca-app-pub-5378474904633653/6523262198";

  BannerAd? bannerAd;
  RxBool bannerisLoaded = false.obs;
  final String bannerAdunit = "ca-app-pub-5378474904633653/3392566351";

  loaBannerAds() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdunit,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            bannerisLoaded.value = true;
            log("$BannerAd is loaded");
          },
          onAdFailedToLoad: (ad, error) {
            bannerisLoaded.value = false;
            log("Falied to load ad $error");
          },
        ),
        request: AdRequest());
    bannerAd!.load();
  }

  loadnativeAds() {
    nativeAd = NativeAd(
        adUnitId: nativeadUnit,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            nativeAdIsLoaded.value = true;
            log("$NativeAd is loaded");
          },
          onAdFailedToLoad: (ad, error) {
            nativeAdIsLoaded.value = false;
            log("Falied to load ad $error");
          },
        ),
        request: AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    nativeAd?.dispose();
    super.dispose();
  }
}
