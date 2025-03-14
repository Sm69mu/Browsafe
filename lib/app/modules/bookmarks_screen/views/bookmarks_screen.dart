// lib/app/modules/bookmarks_screen/views/bookmarks_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/local_storage/bookmarks_storage.dart';
import '../../web_screen/views/web_screen.dart';

class BookmarksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookmarks = BookmarkStorage.getAllBookmarks();

    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks')),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = bookmarks[index];
          return ListTile(
            leading: Icon(Icons.bookmark),

            subtitle: Text(bookmark.url),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await BookmarkStorage.deleteBookmark(index);
                Get.forceAppUpdate();
              },
            ),
            onTap: () => Get.to(() => WebScreen(url: bookmark.url)),
          );
        },
      ),
    );
  }
}
