import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_vpn/screens/home_screen.dart';

import 'webscreen.dart';

class BrowserHomeScreen extends StatefulWidget {
  const BrowserHomeScreen({super.key});

  @override
  State<BrowserHomeScreen> createState() => _BrowserHomeScreenState();
}

class _BrowserHomeScreenState extends State<BrowserHomeScreen> {
  final TextEditingController SearchController = TextEditingController();
  void searchOrQueary() {
    String queary = SearchController.text.trim();
    Uri? uri = Uri.tryParse(queary);
    bool isUri = Uri.parse(queary).isAbsolute;
    if (isUri) {
      Get.to(() => WebScreen(
            url: queary,
          ));
    } else {
      String searchUrl = "https://www.google.com/search?q=$queary";
      Get.to(() => WebScreen(
            url: searchUrl,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 23,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => HomeScreen());
                },
                icon: Icon(Icons.vpn_key_outlined))
          ],
          title: Text(
            "Browsafe",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  controller: SearchController,
                  decoration: InputDecoration(
                    hintText: "Search anything in Privet ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  )),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    searchOrQueary();
                  },
                  child: Text("search")),
            )
          ],
        ),
      ),
    );
  }
}
