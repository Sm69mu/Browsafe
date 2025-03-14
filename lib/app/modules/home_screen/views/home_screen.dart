import 'package:Browsafe/app/constants/controllers/ad_controller.dart';
import 'package:Browsafe/app/modules/bookmarks_screen/views/bookmarks_screen.dart';
import 'package:Browsafe/app/modules/browser_tab_screen/controller/browser_tab_controller.dart';
import 'package:Browsafe/app/modules/history_screen/views/history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../utils/responsive.dart';
import '../../../widgets/favorite_URL_widget.dart';
import '../../../widgets/more_widget.dart';
import '../../../widgets/news_widget.dart';
import '../../browser_tab_screen/views/browser_tab_screen.dart';
import '../../credits_screen/views/credits_screen.dart';
import '../../network_details_screen/views/network_details_screen.dart';
import '../../signup_screen/views/signup_screen.dart';
import '../../vpn_screen/views/vpn_screen.dart';
import '../controllers/home_controllers.dart';
import '../../../data/services/vpn_engine/vpn_engine.dart';
import '../../web_screen/views/web_screen.dart';

class BrowserHomeScreen extends StatefulWidget {
  const BrowserHomeScreen({super.key});

  @override
  State<BrowserHomeScreen> createState() => _BrowserHomeScreenState();
}

class _BrowserHomeScreenState extends State<BrowserHomeScreen> {
  final _controller = Get.put(HomeController());
  final _adcontroller = Get.put(AdController());
  final _tabController = Get.put(BrowserTabController());

  final TextEditingController SearchController = TextEditingController();

  void searchOrQueary() {
    String queary = SearchController.text.trim();
    Uri.tryParse(queary);
    bool isUri = Uri.parse(queary).isAbsolute;
    if (isUri) {
      Get.to(() => WebScreen(
            url: queary,
          ));
      _tabController.addNewTab(queary);
    } else {
      String searchUrl = "https://www.google.com/search?q=$queary";
      Get.to(() => WebScreen(
            url: searchUrl,
          ));
      _tabController.addNewTab(searchUrl);
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
              colors: [Color.fromRGBO(76, 10, 87, 1), Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => BrowserTabviewScreen());
              },
              icon: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.7),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(_tabController.tabs.length.toString())
                    .paddingSymmetric(vertical: 2, horizontal: 7),
              ),
              iconSize: 25,
            ),
            // Tooltip(
            //   message: "VPN",
            //   child: IconButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //         shape: BeveledRectangleBorder(),
            //         context: context,
            //         builder: (BuildContext context) {
            //           return ClipRRect(
            //             borderRadius: BorderRadius.circular(25),
            //             child: HomeScreen(),
            //           );
            //         },
            //       );
            //     },
            //     icon: Obx(
            //       () => Icon(
            //         _controller.vpnstate.value == VpnEngine.vpnConnected
            //             ? Icons.vpn_key_outlined
            //             : Icons.vpn_key_off_outlined,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.1),
              ),
              child: CustomPopupMenu(
                menuItems: [
                  CustomMenuItem(
                    icon: Icons.network_check,
                    title: "Network Details",
                    onTap: () => Get.to(() => NetworkDetailsScreen()),
                  ),
                  CustomMenuItem(
                    icon: Icons.key_rounded,
                    title: "VPN",
                    onTap: () {
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
                  ),
                  CustomMenuItem(
                    icon: Icons.history_rounded,
                    title: "History",
                    onTap: () => Get.to(() => HistoryScreen()),
                  ),
                  CustomMenuItem(
                    icon: Icons.star_border,
                    title: "Bookmarks",
                    onTap: () {
                      Get.to(() => BookmarksScreen());
                    },
                  ),
                  CustomMenuItem(
                    icon: Icons.info_outline,
                    title: "About",
                    onTap: () => Get.to(() => CreditsScreen()),
                  ),
                  CustomMenuItem(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                      Get.offAll(() => SignupScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 100,
              ),
              Text(
                "Browsafe",
                style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.bold,
                    fontSize: ScaleSize.textScaleFactor(context) * 35),
              ),
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 20,
              ),

              //Search bar
              Padding(
                padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: ScreenUtils.screenHeight(context) / 30),
                child: TextField(
                    keyboardType: TextInputType.url,
                    onSubmitted: (value) {
                      searchOrQueary();
                      SearchController.clear();
                    },
                    controller: SearchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.13),
                      hintText: "Search or type URL ",
                      hintStyle:
                          GoogleFonts.urbanist(fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )),
              ),

              //Favourite panel with horizontal scroll
              Container(
                  height: ScreenUtils.screenHeight(context) / 8,
                  width: ScreenUtils.screenWidth(context) - 30,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller.favoriteSites.length,
                              itemBuilder: (context, index) {
                                return FavoriteUrlWidget(
                                  isLongPress: true,
                                  onDelete: (index) {
                                    _controller.removeFavorite(index);
                                  },
                                  onEdit: (index) {
                                    // Handle edit
                                  },
                                  onClick: () {
                                    Get.to(() => WebScreen(
                                          url: _controller
                                                  .favoriteSites[index].url ??
                                              "",
                                        ));
                                  },
                                  url: _controller.favoriteSites[index].url ??
                                      "",
                                  title:
                                      _controller.favoriteSites[index].title ??
                                          "",
                                  index: index,
                                );
                              }),
                          FavoriteUrlWidget(
                            isLongPress: false,
                            onClick: _controller.onAddClick,
                            url: "",
                            title: 'Add URL',
                            index: _controller.favoriteSites.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15))),

              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtils.screenWidth(context) - 20,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Obx(
                    () => CustomPopupMenu(
                      menuItems: [
                        CustomMenuItem(
                          icon: Icons.rss_feed_rounded,
                          title: _controller.isNewsEnabled.value
                              ? "Turn off News"
                              : "Turn on News",
                          onTap: () => _controller.toggleNews(),
                        ),
                      ],
                    ).paddingAll(2),
                  ),
                ),
              ).paddingAll(5),

              Obx(
                () => _controller.isNewsEnabled.value
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        height: ScreenUtils.screenHeight(context) / 2.2,
                        width: ScreenUtils.screenWidth(context) - 30,
                        child: Obx(
                          () => _controller.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  itemCount: _controller.news.length >= 20
                                      ? 20
                                      : _controller.news.length,
                                  itemBuilder: (context, index) {
                                    final newsItem = _controller.news[index];
                                    return InkWell(
                                      onTap: () => Get.to(
                                          WebScreen(url: newsItem['url']!)),
                                      child: NewsWidget(
                                        title: newsItem['title']!,
                                        description: newsItem['description']!,
                                        imageUrl: newsItem['urlToImage']!,
                                        url: newsItem['url']!,
                                      ).paddingSymmetric(vertical: 5),
                                    );
                                  }),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        height: ScreenUtils.screenHeight(context) / 6,
                        width: ScreenUtils.screenWidth(context) - 30,
                        child: Center(
                          child: Text(
                            "News is disabled",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    ScaleSize.textScaleFactor(context) * 20),
                          ),
                        ),
                      ),
              ),

              //Ad container
              // Obx(() => Container(
              //     child: _adcontroller.nativeAdIsLoaded.value
              //         ? ConstrainedBox(
              //             constraints: BoxConstraints(
              //               maxHeight: ScreenUtils.screenHeight(context) / 6,
              //               minHeight: ScreenUtils.screenHeight(context) / 10,
              //             ),
              //             child: SizedBox()

              //             //AdWidget(ad: _adcontroller.nativeAd!),
              //             )
              //         : SizedBox()))
            ],
          ),
        ),
      ),
    );
  }
}
