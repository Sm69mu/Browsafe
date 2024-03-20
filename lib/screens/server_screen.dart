import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_vpn/controllers/location_controller.dart';
import 'package:meme_vpn/utils/responsive.dart';
import 'package:meme_vpn/widgets/vpn_card.dart';

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
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              " Select Location (${controller.vpnslist.length}) Available ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScaleSize.textScaleFactor(context) * 20),
            ),
          ),
          body: controller.isloading.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : controller.vpnslist.isEmpty
                  ? Center(
                      child: Text(
                      "No vpn 😪",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ))
                  : _vpnData(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.getVpndata();
            },
            child: Icon(Icons.refresh_rounded),
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
