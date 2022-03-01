import 'package:eng_questions/datas/models/base_models/base_service_model.dart';

class QuestionModel extends BaseServiceModel {
  int? id;
  String? test;
  int? questionNumber;
  String? questionDesc;
  String? ansverA;
  String? ansverB;
  String? ansverC;
  String? ansverD;
  String? answerDesc;
  int? correctAnswer;
  String? correctAnswerStr;

  QuestionModel(
      {this.id,
      this.test,
      this.questionNumber,
      this.questionDesc,
      this.ansverA,
      this.ansverB,
      this.ansverC,
      this.ansverD,
      this.answerDesc,
      this.correctAnswer,
      this.correctAnswerStr});

  @override
  fromMap(Map<String, dynamic> map) => QuestionModel(
        id: map["id"],
        ansverA: map["ansverA"],
        ansverB: map["ansverB"],
        ansverC: map["ansverC"],
        ansverD: map["ansverD"],
        answerDesc: map["answerDesc"],
        correctAnswer: map["correctAnswer"],
        correctAnswerStr: map["correctAnswerStr"],
        questionDesc: map["questionDesc"],
        questionNumber: map["questionNumber"],
        test: map["test"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "ansverA": ansverA,
        "ansverB": ansverB,
        "ansverC": ansverC,
        "ansverD": ansverD,
        "answerDesc": answerDesc,
        "correctAnswer": correctAnswer,
        "correctAnswerStr": correctAnswerStr,
        "questionDesc": questionDesc,
        "questionNumber": questionNumber,
        "test": test,
      };
}
