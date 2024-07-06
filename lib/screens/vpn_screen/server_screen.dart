import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/location_controller.dart';
import '../../widgets/vpn_card.dart';

class Vpnservers extends StatelessWidget {
  Vpnservers({super.key});

  final controller = LocationController();
  @override
  Widget build(BuildContext context) {
    if (controller.vpnslist.isEmpty) {
      controller.getVpndata();
    }

    return Obx(
      () => Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: controller.isloading.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : controller.vpnslist.isEmpty
                  ? Center(
                      child: Text(
                      "No vpn 😪",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold, fontSize: 27),
                    ))
                  : _vpnData(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              controller.getVpndata();
            },
            label: Text(
              "Refresh",
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
            ),
            icon: Icon(Icons.refresh_rounded),
          ),
        ),
      ),
    );
  }

  _vpnData() => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: controller.vpnslist.length,
        itemBuilder: ((context, index) => VpnCard(
              vpn: controller.vpnslist[index],
            )),
      );
}
