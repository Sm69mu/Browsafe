// lib/app/data/models/browsertab_model.dart
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';

@HiveType(typeId: 1)
class BrowserTab {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  String url;
  
  @HiveField(3)
  String favicon;
  
  @HiveField(4) 
  bool isActive;

  WebViewController? controller;

  BrowserTab({
    required this.id,
    required this.title,
    required this.url, 
    this.favicon = '',
    this.isActive = false,
    this.controller,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'url': url,
    'favicon': favicon,
    'isActive': isActive,
  };

  factory BrowserTab.fromJson(Map<String, dynamic> json) => BrowserTab(
    id: json['id'],
    title: json['title'],
    url: json['url'],
    favicon: json['favicon'],
    isActive: json['isActive'],
  );
}