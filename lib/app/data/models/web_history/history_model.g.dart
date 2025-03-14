// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrowserHistoryAdapter extends TypeAdapter<BrowserHistory> {
  @override
  final int typeId = 2;

  @override
  BrowserHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrowserHistory(
      url: fields[0] as String,
      title: fields[1] as String,
      visitTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BrowserHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.visitTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrowserHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
