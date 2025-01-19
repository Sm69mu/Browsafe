import 'package:get/get.dart';

import '../vpn_apis/apis.dart';
import '../../../constants/helpers/pref.dart';
import '../../models/vpn.dart';


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
