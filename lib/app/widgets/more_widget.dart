// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../modules/credits_screen/views/credits_screen.dart';
// import '../modules/network_details_screen/views/network_details_screen.dart';
// import '../modules/signup_screen/views/signup_screen.dart';
// import '../modules/vpn_screen/views/vpn_screen.dart';

// class MoreWidget extends StatelessWidget {
//   const MoreWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       splashRadius: 12,
//       padding: EdgeInsets.all(6),
//       shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem(
//               onTap: () => Get.to(() => NetworkDetailsScreen()),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.network_check),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Network Details"),
//                 ],
//               )),
//           PopupMenuItem(
//               onTap: () => Get.to(() => CreditsScreen()),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.person),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Credits"),
//                 ],
//               )),
//           PopupMenuItem(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(Icons.lock_outline),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Vault"),
//             ],
//           )),
//           PopupMenuItem(
//               onTap: () async {
//                 await GoogleSignIn().signOut();
//                 FirebaseAuth.instance.signOut();
//                 Get.to(() => SignupScreen());
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.logout_outlined),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Logout"),
//                 ],
//               ))
//         ];
//       },
//     );
//   }
// }

// class Morewebwidget extends StatelessWidget {
//   final InAppWebViewController controller;
//   const Morewebwidget({
//     super.key,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       splashRadius: 12,
//       padding: EdgeInsets.all(6),
//       shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () async {
//                   final messenger = ScaffoldMessenger.of(context);
//                   if (await controller.canGoBack()) {
//                     await controller.goBack();
//                   } else {
//                     messenger.showSnackBar(
//                       const SnackBar(content: Text('No back history item')),
//                     );
//                     return;
//                   }
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.arrow_forward),
//                 onPressed: () async {
//                   final messenger = ScaffoldMessenger.of(context);
//                   if (await controller.canGoForward()) {
//                     await controller.goForward();
//                   } else {
//                     messenger.showSnackBar(
//                       const SnackBar(content: Text('No forward history item')),
//                     );
//                     return;
//                   }
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.refresh),
//                 onPressed: () {
//                   controller.reload();
//                 },
//               ),
//             ],
//           )),
//           PopupMenuItem(
//               onTap: () {
//                 showModalBottomSheet(
//                     shape: BeveledRectangleBorder(),
//                     context: context,
//                     builder: (BuildContext context) {
//                       return ClipRRect(
//                           borderRadius: BorderRadius.circular(25),
//                           child: HomeScreen());
//                     });
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.vpn_key),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("VPN status"),
//                 ],
//               )),
//           PopupMenuItem(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(Icons.share),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Share"),
//             ],
//           )),
//           PopupMenuItem(
//               onTap: () => Get.to(() => NetworkDetailsScreen()),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.network_check),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text("Network Details"),
//                 ],
//               )),
//           PopupMenuItem(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(Icons.lock_outline),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Vault"),
//             ],
//           )),
//         ];
//       },
//     );
//   }
// }

// lib/app/widgets/custom_popup_menu.dart

import 'package:flutter/material.dart';

// Menu item model
class CustomMenuItem {
  final IconData icon;
  final String title;
  final Function() onTap;

  CustomMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

// Reusable popup menu widget
class CustomPopupMenu extends StatelessWidget {
  final List<CustomMenuItem> menuItems;
  final double? splashRadius;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomPopupMenu({
    Key? key,
    required this.menuItems,
    this.splashRadius = 12,
    this.padding = const EdgeInsets.all(6),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: splashRadius,
      padding: padding!,
      shape: BeveledRectangleBorder(borderRadius: borderRadius!),
      itemBuilder: (context) {
        return menuItems.map((item) {
          return PopupMenuItem(
            onTap: item.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(item.icon),
                SizedBox(width: 10),
                Text(item.title),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}