import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 2)
class BrowserHistory {
  @HiveField(0)
  final String url;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final DateTime visitTime;

  BrowserHistory({
    required this.url,
    required this.title,
    required this.visitTime,
  });

  Map<String, dynamic> toJson() => {
    'url': url,
    'title': title, 
    'visitTime': visitTime.toIso8601String(),
  };

  factory BrowserHistory.fromJson(Map<String, dynamic> json) => BrowserHistory(
    url: json['url'],
    title: json['title'],
    visitTime: DateTime.parse(json['visitTime']),
  );
}