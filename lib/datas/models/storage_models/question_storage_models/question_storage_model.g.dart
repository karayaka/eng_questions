// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionStorageModelAdapter extends TypeAdapter<QuestionStorageModel> {
  @override
  final int typeId = 2;

  @override
  QuestionStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionStorageModel(
      testId: fields[0] as int,
      questionId: fields[1] as int,
      userId: fields[2] as int,
      answerStatus: fields[3] as int,
      questionNumber: fields[4] as int,
      answerDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionStorageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.testId)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.answerStatus)
      ..writeByte(4)
      ..write(obj.questionNumber)
      ..writeByte(5)
      ..write(obj.answerDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
