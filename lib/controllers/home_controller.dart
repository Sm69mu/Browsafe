import 'dart:convert';

import 'package:get/get.dart';

import '../helpers/dialogs.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn> vpninfo = Pref.vpn.obs;
  final vpnstate = VpnEngine.vpnDisconnected.obs;
  final RxBool vpnswitcch = false.obs;
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
      vpnswitcch.value = true;
    } else {
      VpnEngine.stopVpn();
      vpnswitcch.value = false;
      Mydialogs.success(msg: "Vpn disconnected");
    }
  }
}
