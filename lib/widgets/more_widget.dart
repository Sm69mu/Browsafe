import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meme_vpn/screens/credits_screen.dart';
import 'package:meme_vpn/screens/network_details_screen.dart';
import 'package:meme_vpn/screens/signup_screen.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              onTap: () => Get.to(() => NetworkDetailsScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.network_check),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Network Details"),
                ],
              )),
          PopupMenuItem(
              onTap: () => Get.to(() => CreditsScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Credits"),
                ],
              )),
          PopupMenuItem(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.feedback_outlined),
              SizedBox(
                width: 10,
              ),
              Text("Feedback"),
            ],
          )),
          PopupMenuItem(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.report_gmailerrorred),
              SizedBox(
                width: 10,
              ),
              Text("Report"),
            ],
          )),
          PopupMenuItem(
              onTap: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Get.to(() => SignupScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Logout"),
                ],
              ))
        ];
      },
    );
  }
}
