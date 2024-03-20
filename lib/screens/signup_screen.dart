import 'package:flutter/material.dart';
import 'package:meme_vpn/services/auth_services.dart';
import 'package:meme_vpn/utils/responsive.dart';

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
          body: Column(
            children: [
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text('Before you start your dab dab dab first Login',
                    style: new TextStyle(
                        fontSize: ScaleSize.textScaleFactor(context) * 30,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient1)),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                      "assets/images/memes/Screenshot 2024-03-15 125953.png"),
                ),
              ),
              SizedBox(
                height: ScreenUtils.screenHeight(context) / 10,
              ),
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Auth().signInwithGoogle();
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
                            width: 40,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
