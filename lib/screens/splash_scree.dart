import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/responsive.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.off(()=>HomeScreen());
    });
  }

  final Shader linearGradient1 = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 81, 167, 224),
      Color.fromARGB(255, 32, 95, 197)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: ScreenUtils.screenHeight(context) * .1,
              left: ScreenUtils.screenWidth(context) * .25,
              child: Image.asset(
                "assets/images/vpn.png",
                width: ScreenUtils.screenWidth(context) * .5,
              )),
          Positioned(
              width: ScreenUtils.screenWidth(context),
              top: ScreenUtils.screenHeight(context) * .4,
              child: Text(
                'Meme Vpn',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: ScaleSize.textScaleFactor(context) * 30,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient1),
              )),
          Positioned(
              width: ScreenUtils.screenWidth(context),
              bottom: ScreenUtils.screenHeight(context) * .2,
              child: Text(
                'Enjoy Your Mutthi ✊',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: ScaleSize.textScaleFactor(context) * 20,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient1),
              ))
        ],
      ),
    );
  }
}
