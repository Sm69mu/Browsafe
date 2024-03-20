import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_vpn/screens/server_screen.dart';
import 'package:meme_vpn/utils/responsive.dart';

class SelectServer extends StatelessWidget {
  const SelectServer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        showModalBottomSheet(
            shape: BeveledRectangleBorder(),
            context: context,
            builder: (BuildContext context) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(25), child: Vpnservers());
            });
      },
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.globe),
            SizedBox(
              width: 10,
            ),
            Text(
              "Select Server",
              style: TextStyle(
                  fontSize: ScaleSize.textScaleFactor(context) * 19,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(Icons.arrow_forward_ios_rounded),
            )
          ],
        ),
        height: ScreenUtils.screenHeight(context) / 13,
        width: ScreenUtils.screenWidth(context) / 1.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(69, 255, 255, 255)),
      ),
    );
  }
}
