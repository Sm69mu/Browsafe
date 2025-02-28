import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/responsive.dart';
import '../constants/assets/api_endpoints.dart';

class FavoriteUrlWidget extends StatefulWidget {
  final String url;
  final String title;
  final dynamic icon;
  final dynamic onClick;
  final bool isLongPress;
  final Function(int index)? onDelete; 
  final Function(int index)? onEdit;
  final int index;

  const FavoriteUrlWidget({
    super.key,
    required this.url,
    required this.title,
    this.icon,
    required this.onClick,
    required this.isLongPress,
    this.onDelete,
    this.onEdit,
    required this.index,
  });

  @override
  State<FavoriteUrlWidget> createState() => _FavoriteUrlWidgetState();
}

class _FavoriteUrlWidgetState extends State<FavoriteUrlWidget> {
  void _showPopupMenu(TapDownDetails details) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx + 1,
        details.globalPosition.dy + 1,
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.edit, color: Colors.grey),
            title: Text('Edit'),
            contentPadding: EdgeInsets.zero,
          ),
          onTap: () {
            if (widget.onEdit != null) {
              widget.onEdit!(widget.index);
            }
          },
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete, color: Colors.grey),
            title: Text('Delete'),
            contentPadding: EdgeInsets.zero,
          ),
          onTap: () {
            if (widget.onDelete != null) {
              widget.onDelete!(widget.index);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: ScreenUtils.screenWidth(context) / 5,
      child: Column(
        children: [
          GestureDetector(
            onTapDown: widget.isLongPress
                ? (details) => _showPopupMenu(details)
                : null,
            onTap: widget.onClick,
            child: Container(
                    child: widget.url.isNotEmpty
                        ? Image.network(
                            ApiEndpoints.faviconURL + widget.url,
                            fit: BoxFit.contain,
                          ).paddingAll(10)
                        : Icon(Icons.add, color: Colors.black, size: 30),
                    height: ScreenUtils.screenHeight(context) * .07,
                    width: ScreenUtils.screenHeight(context) * .07,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(15)))
                .paddingOnly(top: ScreenUtils.screenHeight(context) / 60),
          ),
          Text(
            widget.title != null ? widget.title : widget.url,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.w600),
          ).paddingOnly(
            top: ScreenUtils.screenHeight(context) / 60,
          ),
        ],
      ),
    ).paddingOnly(left: ScreenUtils.screenWidth(context) / 30);
  }
}
