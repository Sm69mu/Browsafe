import 'package:hive/hive.dart';

part 'favourite_sites.g.dart';

@HiveType(typeId: 1)
class FavoriteSite {
  @HiveField(0)
  final String? url;

  @HiveField(1)
  final String? title;

  FavoriteSite({required this.title, required this.url});
}
