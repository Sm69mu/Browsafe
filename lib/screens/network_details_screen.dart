import 'package:Browsafe/controllers/ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../apis/apis.dart';
import '../models/ipdetails.dart';
import '../models/network_data.dart';
import '../utils/responsive.dart';
import '../widgets/network_card.dart';

class NetworkDetailsScreen extends StatefulWidget {
  NetworkDetailsScreen({super.key});

  @override
  State<NetworkDetailsScreen> createState() => _NetworkDetailsScreenState();
}

class _NetworkDetailsScreenState extends State<NetworkDetailsScreen> {
  final _adcontroller = Get.put(AdController());

  @override
  void initState() {
    super.initState();
    _adcontroller.loaBannerAds();
  }

  @override
  Widget build(BuildContext context) {
    final iPdata = IPdetails.fromJson({}).obs;
    Apis.ipapis(iPdata);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Network Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScaleSize.textScaleFactor(context) * 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
          body: Obx(
            () => ListView(
              children: [
                Networkcard(
                    data: Networkdata(
                        title: 'IP Address',
                        subtitle: iPdata.value.query,
                        icon: Container(
                          height: ScreenUtils.screenHeight(context) / 18,
                          width: ScreenUtils.screenHeight(context) / 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                        ))),
                Networkcard(
                    data: Networkdata(
                        title: 'Internet Provider',
                        subtitle: iPdata.value.isp,
                        icon: Container(
                          height: ScreenUtils.screenHeight(context) / 18,
                          width: ScreenUtils.screenHeight(context) / 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Icon(
                            Icons.location_city_rounded,
                            color: Colors.black,
                          ),
                        ))),
                Networkcard(
                    data: Networkdata(
                        title: 'Location',
                        subtitle: iPdata.value.country.isEmpty
                            ? "Fetching...."
                            : '${iPdata.value.city} , ${iPdata.value.regionName} , ${iPdata.value.country}',
                        icon: Container(
                          height: ScreenUtils.screenHeight(context) / 18,
                          width: ScreenUtils.screenHeight(context) / 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Icon(
                            Icons.location_history,
                            color: Colors.black,
                          ),
                        ))),
                Networkcard(
                    data: Networkdata(
                        title: 'Pincode',
                        subtitle: iPdata.value.zip,
                        icon: Container(
                          height: ScreenUtils.screenHeight(context) / 18,
                          width: ScreenUtils.screenHeight(context) / 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.black,
                          ),
                        ))),
                Networkcard(
                    data: Networkdata(
                        title: 'Time Zone',
                        subtitle: iPdata.value.timezone,
                        icon: Container(
                          height: ScreenUtils.screenHeight(context) / 18,
                          width: ScreenUtils.screenHeight(context) / 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Icon(
                            Icons.timer_rounded,
                            color: Colors.black,
                          ),
                        ))),
              ],
            ),
          ),
          bottomNavigationBar: Obx(() => Container(
              child: _adcontroller.bannerisLoaded.value
                  ? ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: 100, minHeight: 100),
                      child: AdWidget(ad: _adcontroller.bannerAd!),
                    )
                  : SizedBox()))),
    );
  }
}
