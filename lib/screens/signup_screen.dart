import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../services/auth_services.dart';
import '../utils/responsive.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient1 = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 103, 179, 230),
        Color.fromARGB(255, 33, 97, 202)
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));
    return Container(
      decoration: BoxDecoration(
          //app background color
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtils.screenHeight(context) / 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text('Use secure connection to search anything 💻',
                      style: new TextStyle(
                          fontSize: ScaleSize.textScaleFactor(context) * 25,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient1)),
                ),
                SizedBox(
                  height: ScreenUtils.screenHeight(context) / 2.2,
                  child: Lottie.asset(
                      "assets/animation/Animation - 1719567776988.json"),
                ),
                SizedBox(
                  height: ScreenUtils.screenHeight(context) / 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Auth.signInwithGoogle();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: ScreenUtils.screenHeight(context) / 15,
                            width: ScreenUtils.screenWidth(context) / 1.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                Image.asset(
                                  'assets/images/google.256x256.png',
                                  width: 30,
                                  fit: BoxFit.contain,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.screenHeight(context) / 30,
                    ),
                    Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Auth.signinanonomusly();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: ScreenUtils.screenHeight(context) / 15,
                            width: ScreenUtils.screenWidth(context) / 1.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Login as Guest",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.person_4_outlined,
                                  color: Colors.black,
                                  size: ScaleSize.textScaleFactor(context) * 35,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
