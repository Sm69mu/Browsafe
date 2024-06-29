import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/location_controller.dart';
import '../widgets/vpn_card.dart';


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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 90, 7, 104), Colors.black])),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          body: controller.isloading.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : controller.vpnslist.isEmpty
                  ? Center(
                      child: Text(
                      "No vpn 😪",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
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
