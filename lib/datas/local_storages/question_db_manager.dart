import 'package:eng_questions/core/component_models/chart_model.dart';
import 'package:eng_questions/core/component_models/question_stepper_component_model.dart';
import 'package:eng_questions/core/component_models/test_list_card_model.dart';
import 'package:eng_questions/datas/local_storages/storage_const.dart';
import 'package:eng_questions/datas/models/storage_models/question_storage_models/question_storage_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'base_db_manager.dart';

class QuestionDbManager extends BaseDbManager<QuestionStorageModel> {
  QuestionDbManager() : super(StorageConst.question_storage_model_name);

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(StorageConst.question_storage_model_key)) {
      Hive.registerAdapter(QuestionStorageModelAdapter());
    }
  }

  Future<TestListCardModel> calculateUserScore(int testID, int userID) async {
    try {
      var retVal = TestListCardModel(
        correctAnswerCount: 0,
        lastQuestionNumber: 0,
        emtyAnverCount: 0,
        id: 0,
        questionCount: 0,
        wrongAnswerCount: 0,
        onloaded: false,
      );

      var values = getValues(
          (element) => element!.testId == testID && element.userId == userID);
      if (values == null) {
        return retVal;
      }
      retVal.correctAnswerCount =
          values.where((element) => element!.answerStatus == 1).length;
      retVal.wrongAnswerCount =
          values.where((element) => element!.answerStatus == -1).length;
      retVal.emtyAnverCount =
          values.where((element) => element!.answerStatus == 0).length;
      if (values.isNotEmpty) {
        retVal.lastQuestionNumber = values.last!.questionNumber;
      }

      return retVal;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<QuestionStepperComponentModel> calculateTestScore(
      int testID, int userID) async {
    try {
      var retVal = QuestionStepperComponentModel(
        correctAnsverCount: 0,
        passAnsverQuestion: 0,
        questionCount: 0,
        wrongAnsverCount: 0,
        questionNumber: 0,
      );
      var values = getValues(
          (element) => element!.testId == testID && element.userId == userID);
      if (values == null) {
        return retVal;
      }
      retVal.correctAnsverCount =
          values.where((element) => element!.answerStatus == 1).length;
      retVal.wrongAnsverCount =
          values.where((element) => element!.answerStatus == -1).length;
      retVal.passAnsverQuestion =
          values.where((element) => element!.answerStatus == 0).length;
      return retVal;
    } catch (e) {
      throw e;
    }
  }

  Future<void> resetTest(int testID, int userID) async {
    try {
      var values = getValues(
          (element) => element!.testId == testID && element.userId == userID);
      if (values != null) {
        for (var e in values) {
          removeItem(e!.key);
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<int?> questionAnswered(QuestionStorageModel model) async {
    try {
      var retVal = await getFistWhere((e) => e!.questionId == model.questionId);
      if (retVal != null) {
        return await putItem(retVal.key, model);
      } else {
        return await addItem(model);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<ChartModel>> prepareChartModel(int? userId) async {
    try {
      List<ChartModel> series = [];
      if (userId == null) return series;
      var now = DateTime.now();
      for (var i = 0; i <= 8; i++) {
        var values = getValues((e) =>
            e?.userId == userId &&
            e?.answerDate.day == now.day &&
            e?.answerDate.month == now.month &&
            e?.answerDate.year == now.year);
        if (values == null) {
          return series;
        }
        series.add(ChartModel(
            caption: "${now.day}/${now.month}", value: values.length));
        now = now.add(const Duration(days: -1));
      }
      series = List.from(series.reversed);
      return series;
    } catch (e) {
      throw e;
    }
  }
}
