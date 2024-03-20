import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meme_vpn/utils/responsive.dart';
import 'package:meme_vpn/widgets/credits_link_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatefulWidget {
  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {
  final Uri _linkedinUrl =
      Uri.parse('https://www.linkedin.com/in/heysoumyajitmukherjee/');
  final Uri _githubUrl = Uri.parse('https://github.com/Sm69mu');
  final Uri _instagramUrl =
      Uri.parse('https://www.instagram.com/soumyajit__mukherjee/');
  final Uri _twitterUrl = Uri.parse('https://twitter.com/Soumyaj46796963');
  Future<void> _likedinurl() async {
    if (!await launchUrl(_linkedinUrl)) {
      throw Exception('Could not launch $_linkedinUrl');
    }
  }

  Future<void> _github() async {
    if (!await launchUrl(_githubUrl)) {
      throw Exception('Could not launch $_githubUrl');
    }
  }

  Future<void> _instagram() async {
    if (!await launchUrl(_instagramUrl)) {
      throw Exception('Could not launch $_instagramUrl');
    }
  }

  Future<void> _twitter() async {
    if (!await launchUrl(_twitterUrl)) {
      throw Exception('Could not launch $_twitterUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 76, 10, 87), Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Credits",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  "Developed by:",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Soumyajit Mukherjee",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "soumyajitmukherjee271@gmail.com",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: ScreenUtils.screenHeight(context) / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CreditsLink(
                      onpress: _likedinurl,
                      icon: FontAwesomeIcons.linkedin,
                    ),
                    CreditsLink(
                      onpress: _github,
                      icon: FontAwesomeIcons.github,
                    ),
                    CreditsLink(
                      onpress: _instagram,
                      icon: FontAwesomeIcons.instagram,
                    ),
                    CreditsLink(
                      onpress: _twitter,
                      icon: FontAwesomeIcons.xTwitter,
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtils.screenHeight(context) / 15),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtils.screenHeight(context) * .06,
                    width: ScreenUtils.screenWidth(context) * .3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Text(
                      "Close",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
