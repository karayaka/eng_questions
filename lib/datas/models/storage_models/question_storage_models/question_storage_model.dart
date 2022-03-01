import 'package:eng_questions/datas/local_storages/storage_const.dart';
import 'package:hive_flutter/adapters.dart';

part 'question_storage_model.g.dart';

@HiveType(typeId: StorageConst.question_storage_model_key)
class QuestionStorageModel extends HiveObject{

  @HiveField(0)
  int testId;
  @HiveField(1)
  int questionId;
  @HiveField(2)
  int userId;
  @HiveField(3)
  int answerStatus;
  @HiveField(4)
  int questionNumber;
  @HiveField(5)
  DateTime answerDate=DateTime.now();

  QuestionStorageModel({
    required this.testId,
    required this.questionId,
    required this.userId,
    required this.answerStatus,
    required this.questionNumber,
    required this.answerDate
  });
}