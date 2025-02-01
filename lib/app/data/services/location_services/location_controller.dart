import 'package:get/get.dart';

import '../vpn_apis/vpn_apis.dart';
import '../local_storage/vpnlist_storage.dart';
import '../../models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnslist = vpnProfilesStorage.vpnList;

  final RxBool isloading = false.obs;
  Future<void> getVpndata() async {
    isloading.value = true;
    vpnslist.clear();
    vpnslist = await Apis.vpnApis();
    isloading.value = false;
  }
}
