import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/other_screens/credits_screen.dart';
import '../screens/other_screens/network_details_screen.dart';
import '../screens/signup_screen.dart';

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: 12,
      padding: EdgeInsets.all(6),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              Icon(Icons.lock_outline),
              SizedBox(
                width: 10,
              ),
              Text("Vault"),
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
