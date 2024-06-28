import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meme_vpn/utils/responsive.dart';
import 'package:meme_vpn/widgets/more_widget.dart';

import '../../controllers/location_controller.dart';
import '../home_screen.dart';
import '../../controllers/home_controller.dart';
import '../../services/vpn_engine.dart';
import 'webscreen.dart';

class BrowserHomeScreen extends StatefulWidget {
  const BrowserHomeScreen({super.key});

  @override
  State<BrowserHomeScreen> createState() => _BrowserHomeScreenState();
}

class _BrowserHomeScreenState extends State<BrowserHomeScreen> {
  final controller = LocationController();
  final _controller = Get.put(HomeController());

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
            MoreWidget(),
          ],
        ),
        body: Column(
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
                    String searchUrl = "https://www.google.com/search?q=$value";
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
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    searchOrQueary();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    minimumSize: Size(60, 60),
                    backgroundColor: Colors.white.withOpacity(0.19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Search",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600,
                            fontSize: ScaleSize.textScaleFactor(context) * 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search_outlined)
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
