import 'package:get/get.dart';
import 'package:meme_vpn/apis/apis.dart';
import 'package:meme_vpn/helpers/pref.dart';
import 'package:meme_vpn/models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnslist = Pref.vpnList;

  final RxBool isloading = false.obs;
  Future<void> getVpndata() async {
    isloading.value = true;
    vpnslist.clear();
    vpnslist = await Apis.vpnApis();
    isloading.value = false;
  }
}
