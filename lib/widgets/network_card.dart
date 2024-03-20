import 'package:flutter/material.dart';
import 'package:meme_vpn/models/network_data.dart';

class Networkcard extends StatelessWidget {
  final Networkdata data;
  Networkcard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.white.withOpacity(0.2),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            leading: data.icon,
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            subtitle: Text(data.subtitle),
            title: Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
