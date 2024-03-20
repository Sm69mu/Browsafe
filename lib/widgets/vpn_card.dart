import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_vpn/controllers/home_controller.dart';
import 'package:meme_vpn/helpers/pref.dart';
import 'package:meme_vpn/models/vpn.dart';
import 'package:meme_vpn/services/vpn_engine.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;
  VpnCard({super.key, required this.vpn});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          controller.vpninfo.value = vpn;
          Pref.vpn = vpn;
          Get.back();
          if (controller.vpnstate.value == VpnEngine.vpnConnected) {
            VpnEngine.stopVpn();
            Future.delayed(Duration(seconds: 2), () {
              controller.connectToVpn();
            });
          } else {
            controller.connectToVpn();
          }
        },
        child: ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.indigo, borderRadius: BorderRadius.circular(12)),
            child: Icon(CupertinoIcons.globe),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          subtitle: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.speed),
              SizedBox(
                width: 5,
              ),
              Text('${_formatBytes(vpn.speed, 1)}'),
            ],
          ),
          title: Text(
            vpn.countrylong,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.person_3),
              SizedBox(
                width: 6,
              ),
              Text("${vpn.numvpnsessions}")
            ],
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
