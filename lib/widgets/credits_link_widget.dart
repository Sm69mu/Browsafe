import 'package:flutter/material.dart';
import 'package:meme_vpn/utils/responsive.dart';

class CreditsLink extends StatelessWidget {
  final IconData icon;
  final onpress;
  const CreditsLink({
    super.key,
    required this.icon,
    this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: ScreenUtils.screenHeight(context) / 15,
          width: ScreenUtils.screenHeight(context) / 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
