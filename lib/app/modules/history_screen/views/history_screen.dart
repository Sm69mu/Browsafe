// lib/app/modules/history_screen/views/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/local_storage/histroy_storage.dart';
import '../../web_screen/views/web_screen.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = HistoryStorage.getAllHistory();

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () async {
              await HistoryStorage.clearHistory();
              Get.back();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          return ListTile(
            leading: Icon(Icons.history),
            title: Text(entry.title),
            subtitle: Text(entry.url),
            trailing: Text(
              '${entry.visitTime.hour}:${entry.visitTime.minute}',
            ),
            onTap: () => Get.to(() => WebScreen(url: entry.url)),
          );
        },
      ),
    );
  }
}
