import 'package:hive/hive.dart';


part 'bookmark_models.g.dart';

@HiveType(typeId: 4) 
class Bookmark {
  // @HiveField(0)
  // final String title;

  @HiveField(0)
  final String url;

  // @HiveField(2)
  // final DateTime dateAdded;

  Bookmark({
   // required this.title,
    required this.url,
   // required this.dateAdded,
  });
}
