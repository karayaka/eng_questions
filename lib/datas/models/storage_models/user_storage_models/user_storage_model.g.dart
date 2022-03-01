// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStorageModelAdapter extends TypeAdapter<UserStorageModel> {
  @override
  final int typeId = 1;

  @override
  UserStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStorageModel(
      NameAndSurname: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserStorageModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.NameAndSurname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
