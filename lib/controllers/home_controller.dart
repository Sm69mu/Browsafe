import 'dart:convert';

import 'package:get/get.dart';
import 'package:meme_vpn/helpers/dialogs.dart';
import 'package:meme_vpn/helpers/pref.dart';
import 'package:meme_vpn/models/vpn.dart';
import 'package:meme_vpn/models/vpn_config.dart';
import 'package:meme_vpn/services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn> vpninfo = Pref.vpn.obs;
  final vpnstate = VpnEngine.vpnDisconnected.obs;
  final RxBool startTimer = false.obs;
  void connectToVpn() {
    if (vpninfo.value.openVPNConfigDataBase64.isEmpty) {
      Mydialogs.info(message: "First Select a Location ");
      return;
    }
    if (vpnstate.value == VpnEngine.vpnDisconnected) {
      final cryptdata =
          Base64Decoder().convert(vpninfo.value.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(cryptdata);
      final vpnConfig = VpnConfig(
        country: vpninfo.value.countrylong,
        username: 'vpn',
        password: 'vpn',
        config: config,
      );
      VpnEngine.startVpn(vpnConfig);
    } else {
      startTimer.value = false;
      VpnEngine.stopVpn();
      Mydialogs.success(msg: "Sabas Marli muthhi");
    }
  }

}
