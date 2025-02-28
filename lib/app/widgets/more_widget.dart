

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