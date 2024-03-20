// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meme_vpn/controllers/home_controller.dart';
import 'package:meme_vpn/screens/network_details_screen.dart';
import 'package:meme_vpn/widgets/select_server_button.dart';
import 'package:meme_vpn/widgets/vpn_details_widget.dart';
import 'package:meme_vpn/widgets/vpn_speed_widget.dart';
import 'package:meme_vpn/widgets/vpn_timer_widget.dart';

import '../services/vpn_engine.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnstate.value = event;
    });
    //grdient color text

    final Shader linearGradient1 = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 103, 179, 230),
        Color.fromARGB(255, 25, 74, 152)
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));

    return Obx(
      () => Container(
        decoration: BoxDecoration(
            //app background color
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => NetworkDetailsScreen());
                    },
                    icon: Icon(
                      Icons.info_outline,
                      size: 27,
                    ))
              ],
              title: Text(
                'Meme Vpn',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: ScaleSize.textScaleFactor(context) * 25,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient1),
              )),
          body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              SizedBox(
                height: 10,
              ),
              //meme image upside vpn button
              Center(
                child: Container(
                  height: ScreenUtils.screenHeight(context) * .25,
                  width: ScreenUtils.screenHeight(context) * .25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/memes/mrega_muthhi.png",
                          ),
                          fit: BoxFit.cover)),
                ),
              ),

              //vpn connect button
              SizedBox(
                height: ScreenUtils.screenHeight(context) * 0.02,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  _controller.connectToVpn();
                  _controller.startTimer.value = !_controller.startTimer.value;
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtils.screenHeight(context) / 14,
                    width: ScreenUtils.screenWidth(context) / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_controller.vpnstate.value ==
                            VpnEngine.vpnDisconnected)
                          Row(
                            children: [
                              Text(
                                "Not Connect",
                                style: TextStyle(
                                    fontSize:
                                        ScaleSize.textScaleFactor(context) * 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                              )
                            ],
                          ),
                        if (_controller.vpnstate == VpnEngine.vpnConnecting)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        if (_controller.vpnstate == VpnEngine.vpnAuthenticating)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        if (_controller.vpnstate == VpnEngine.vpnConnected)
                          Row(
                            children: [
                              Text(
                                "Connected",
                                style: TextStyle(
                                    fontSize:
                                        ScaleSize.textScaleFactor(context) * 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                CupertinoIcons.lock_shield_fill,
                                color: Colors.black,
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),

              // timer widget

              CountDownTimer(
                startTimer: _controller.vpnstate.value == VpnEngine.vpnConnected
                    ? true
                    : false,
              ),

              // data speed widget

              VpnSpeedWidget(),

              //vpn deatils widget
              VpnDeatilsWidget()
            ]),
          ),

          //select server button
          floatingActionButton: SelectServer(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
