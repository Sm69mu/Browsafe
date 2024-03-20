import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meme_vpn/apis/apis.dart';
import 'package:meme_vpn/models/ipdetails.dart';
import 'package:meme_vpn/models/network_data.dart';
import 'package:meme_vpn/screens/credits_screen.dart';
import 'package:meme_vpn/screens/signup_screen.dart';
import 'package:meme_vpn/utils/responsive.dart';
import 'package:meme_vpn/widgets/network_card.dart';

class NetworkDetailsScreen extends StatelessWidget {
  NetworkDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final iPdata = IPdetails.fromJson({}).obs;
    Apis.ipapis(iPdata);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            actions: [
              InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.to(() => CreditsScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.info_outline),
                  ))
            ],
            backgroundColor: Colors.transparent,
            title: Text(
              'IP Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScaleSize.textScaleFactor(context) * 20,
                fontWeight: FontWeight.w600,
              ),
            )),
        body: Obx(
          () => ListView(
            children: [
              Networkcard(
                  data: Networkdata(
                      title: 'IP Address',
                      subtitle: iPdata.value.query,
                      icon: Container(
                        height: ScreenUtils.screenHeight(context) / 18,
                        width: ScreenUtils.screenHeight(context) / 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                      ))),
              Networkcard(
                  data: Networkdata(
                      title: 'Internet Provider',
                      subtitle: iPdata.value.isp,
                      icon: Container(
                        height: ScreenUtils.screenHeight(context) / 18,
                        width: ScreenUtils.screenHeight(context) / 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Icon(
                          Icons.location_city_rounded,
                          color: Colors.black,
                        ),
                      ))),
              Networkcard(
                  data: Networkdata(
                      title: 'Location',
                      subtitle: iPdata.value.country.isEmpty
                          ? "Fetching...."
                          : '${iPdata.value.city} , ${iPdata.value.regionName} , ${iPdata.value.country}',
                      icon: Container(
                        height: ScreenUtils.screenHeight(context) / 18,
                        width: ScreenUtils.screenHeight(context) / 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Icon(
                          Icons.location_history,
                          color: Colors.black,
                        ),
                      ))),
              Networkcard(
                  data: Networkdata(
                      title: 'Pincode',
                      subtitle: iPdata.value.zip,
                      icon: Container(
                        height: ScreenUtils.screenHeight(context) / 18,
                        width: ScreenUtils.screenHeight(context) / 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.black,
                        ),
                      ))),
              Networkcard(
                  data: Networkdata(
                      title: 'Time Zone',
                      subtitle: iPdata.value.timezone,
                      icon: Container(
                        height: ScreenUtils.screenHeight(context) / 18,
                        width: ScreenUtils.screenHeight(context) / 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Icon(
                          Icons.timer_rounded,
                          color: Colors.black,
                        ),
                      ))),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await GoogleSignIn().signOut();
            FirebaseAuth.instance.signOut();
            Get.off(SignupScreen());
          },
          label: Text(
            "Log Out",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          icon: Icon(Icons.logout_rounded),
        ),
      ),
    );
  }
}
