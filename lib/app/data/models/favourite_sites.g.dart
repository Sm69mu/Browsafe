// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_sites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteSiteAdapter extends TypeAdapter<FavoriteSite> {
  @override
  final int typeId = 1;

  @override
  FavoriteSite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteSite(
      title: fields[1] as String?,
      url: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteSite obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteSiteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
