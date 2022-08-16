// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopicInfoAdapter extends TypeAdapter<TopicInfo> {
  @override
  final int typeId = 2;

  @override
  TopicInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopicInfo(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<StoreInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, TopicInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.keyword)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.storeInfoList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
