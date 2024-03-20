import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_vpn/controllers/home_controller.dart';

import 'package:meme_vpn/utils/responsive.dart';

class VpnDeatilsWidget extends StatefulWidget {
  const VpnDeatilsWidget({super.key});

  @override
  State<VpnDeatilsWidget> createState() => _VpnDeatilsWidgetState();
}

class _VpnDeatilsWidgetState extends State<VpnDeatilsWidget> {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<HomeController>();
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // country
            Container(
              height: ScreenUtils.screenHeight(context) / 13,
              width: ScreenUtils.screenWidth(context) / 2.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: ScreenUtils.screenHeight(context) / 16,
                      width: ScreenUtils.screenHeight(context) / 16,
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        CupertinoIcons.globe,
                        size: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      _controller.vpninfo.value.countrylong.isEmpty
                          ? "Country"
                          : _controller.vpninfo.value.countrylong.toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            //ping
            Container(
              height: ScreenUtils.screenHeight(context) / 13,
              width: ScreenUtils.screenWidth(context) / 2.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      _controller.vpninfo.value.ping.isEmpty
                          ? "0"
                          : _controller.vpninfo.value.ping + " ms",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: ScreenUtils.screenHeight(context) / 16,
                      width: ScreenUtils.screenHeight(context) / 16,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        CupertinoIcons.chart_bar_alt_fill,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
