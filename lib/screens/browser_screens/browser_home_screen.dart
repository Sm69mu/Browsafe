import 'package:Browsafe/controllers/ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/responsive.dart';
import '../../widgets/more_widget.dart';
import '../vpn_screen/vpn_screen.dart';
import '../../controllers/vpn_controller.dart';
import '../../services/vpn_engine.dart';
import 'web_screen.dart';

class BrowserHomeScreen extends StatefulWidget {
  const BrowserHomeScreen({super.key});

  @override
  State<BrowserHomeScreen> createState() => _BrowserHomeScreenState();
}

class _BrowserHomeScreenState extends State<BrowserHomeScreen> {
  final _controller = Get.put(HomeController());
  final _adcontroller = Get.put(AdController());

  final TextEditingController SearchController = TextEditingController();

  void searchOrQueary() {
    String queary = SearchController.text.trim();
    Uri.tryParse(queary);
    bool isUri = Uri.parse(queary).isAbsolute;
    if (isUri) {
      Get.to(() => WebScreen(
            url: queary,
          ));
    } else {
      String searchUrl = "https://www.google.com/search?q=$queary";
      Get.to(() => WebScreen(
            url: searchUrl,
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    _adcontroller.loadnativeAds();
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnstate.value = event;
    });
    return Container(
      decoration: BoxDecoration(
          //app background color
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          actions: [
            Tooltip(
              message: "VPN",
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: BeveledRectangleBorder(),
                    context: context,
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: HomeScreen(),
                      );
                    },
                  );
                },
                icon: Obx(
                  () => Icon(
                    _controller.vpnstate.value == VpnEngine.vpnConnected
                        ? Icons.vpn_key_outlined
                        : Icons.vpn_key_off_outlined,
                  ),
                ),
              ),
            ),
            MoreWidget(),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 10,
              ),
              Text(
                "Browsafe",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.bold,
                    fontSize: ScaleSize.textScaleFactor(context) * 35),
              ),
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    onSubmitted: (value) {
                      String searchUrl =
                          "https://www.google.com/search?q=$value";
                      Get.to(() => WebScreen(
                            url: searchUrl,
                          ));
                    },
                    controller: SearchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.13),
                      hintText: "Search anything in Privet ",
                      hintStyle:
                          GoogleFonts.urbanist(fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )),
              ),
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 3,
              ),
              Obx(() => Container(
                  child: _adcontroller.nativeAdIsLoaded.value
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: ScreenUtils.screenHeight(context) / 6,
                            minHeight: ScreenUtils.screenHeight(context) / 10,
                          ),
                          child: AdWidget(ad: _adcontroller.nativeAd!),
                        )
                      : SizedBox()))
            ],
          ),
        ),
      ),
    );
  }
}
