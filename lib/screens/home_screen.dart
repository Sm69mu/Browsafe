import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../services/vpn_engine.dart';
import '../utils/responsive.dart';
import 'server_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnstate.value = event;
    });

    return Obx(
      () => Container(
        decoration: BoxDecoration(
            //app background color
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 99, 14, 114),
              Color.fromARGB(255, 27, 3, 36)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              //connection card
              Card(
                color: Colors.white.withOpacity(0.25),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: _controller.vpninfo.value.countryshort.isEmpty
                        ? Icon(CupertinoIcons.globe)
                        : Image.asset(
                            "assets/flags/${_controller.vpninfo.value.countryshort.toLowerCase()}.png",
                            fit: BoxFit.contain,
                          ),
                  ),
                  title: Text(
                    _controller.vpnstate.value == VpnEngine.vpnDisconnected
                        ? "Not Connect"
                        : _controller.vpnstate.value == VpnEngine.vpnConnecting
                            ? "Connecting..."
                            : _controller.vpnstate.value ==
                                    VpnEngine.vpnAuthenticating
                                ? "Authenticating..."
                                : "Connected",
                    style: TextStyle(
                      fontSize: ScaleSize.textScaleFactor(context) * 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _controller.vpninfo.value.countrylong.isEmpty
                        ? "Not selected"
                        : _controller.vpninfo.value.countrylong.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing:
                      _controller.vpnstate.value == VpnEngine.vpnConnecting
                          ? CircularProgressIndicator()
                          : Tooltip(
                              message: "Connect To VPN",
                              child: Switch(
                                value: _controller.vpnswitcch.value,
                                onChanged: (value) {
                                  _controller.connectToVpn();
                                  _controller.vpnstate.value ==
                                          VpnEngine.vpnConnected
                                      ? _controller.vpnswitcch.value =
                                          !_controller.vpnswitcch.value
                                      : _controller.vpnswitcch.value;
                                  _controller.vpnswitcch.value = value;
                                },
                              ),
                            ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 10,
                ),
              ),
              Divider(),
              //location screen
              SizedBox(
                  height: ScreenUtils.screenHeight(context) / 2.5,
                  width: ScreenUtils.screenWidth(context) - 1,
                  child: Vpnservers())
            ]),
          ),
        ),
      ),
    );
  }
}
