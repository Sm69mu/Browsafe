import 'dart:convert';
import 'dart:developer';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:meme_vpn/helpers/dialogs.dart';
import 'package:meme_vpn/helpers/pref.dart';
import 'package:meme_vpn/models/ipdetails.dart';
import 'package:meme_vpn/models/vpn.dart';

class Apis {
  static Future<List<Vpn>> vpnApis() async {
    final List<Vpn> vpnlist = [];
    try {
      final resposne =
          await get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      final csvString = resposne.body.split('#')[1].replaceAll("*", " ");
      List<List<dynamic>> vList = const CsvToListConverter().convert(csvString);
      final header = vList[0];
      for (var i = 1; i < vList.length - 1; i++) {
        Map<String, dynamic> tempJson = {};
        for (var j = 0; j < header.length; j++) {
          tempJson.addAll({header[j].toString(): vList[i][j]});
        }
        vpnlist.add(Vpn.fromJson(tempJson));
      }
      log(vpnlist.first.countryshort);
    } catch (err) {
      Mydialogs.error(err: err.toString());
    }
    vpnlist.shuffle();
    if (vpnlist.isNotEmpty) {
      Pref.vpnList = vpnlist;
    }
    return vpnlist;
  }

  static Future<void> ipapis( Rx<IPdetails> iPdata) async {
    try {
      final response = await get(Uri.parse("http://ip-api.com/json/"));
      final data = jsonDecode(response.body);
      iPdata.value = IPdetails.fromJson(data);
    } catch (err) {
      Mydialogs.error(err: err.toString());
    }
  }
}
