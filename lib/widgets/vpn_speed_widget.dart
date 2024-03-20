import 'package:flutter/material.dart';
import 'package:meme_vpn/services/vpn_engine.dart';
import 'package:meme_vpn/utils/responsive.dart';

class VpnSpeedWidget extends StatefulWidget {
  const VpnSpeedWidget({super.key});

  @override
  State<VpnSpeedWidget> createState() => _VpnSpeedWidgetState();
}

class _VpnSpeedWidgetState extends State<VpnSpeedWidget> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: VpnEngine.vpnStatusSnapshot(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //download widget

                Container(
                  height: ScreenUtils.screenHeight(context) * 0.14,
                  width: ScreenUtils.screenWidth(context) * 0.44,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: ScreenUtils.screenHeight(context) / 17,
                        width: ScreenUtils.screenWidth(context) / 2.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.2)),
                        child: Text(
                          "${snapshot.data?.byteIn}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: ScreenUtils.screenHeight(context) / 17,
                        width: ScreenUtils.screenWidth(context) / 2.6,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.arrow_downward),
                            Text(
                              'Download',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //upload widget

                Container(
                  height: ScreenUtils.screenHeight(context) * 0.14,
                  width: ScreenUtils.screenWidth(context) * 0.44,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: ScreenUtils.screenHeight(context) / 17,
                        width: ScreenUtils.screenWidth(context) / 2.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.2)),
                        child: Text(
                          "${snapshot.data?.byteOut}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: ScreenUtils.screenHeight(context) / 17,
                        width: ScreenUtils.screenWidth(context) / 2.6,
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.arrow_upward),
                            Text(
                              'Upload',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
  
}
