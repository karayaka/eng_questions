import 'package:eng_questions/core/component_models/chart_model.dart';
import 'package:eng_questions/core/component_models/question_stepper_component_model.dart';
import 'package:eng_questions/core/component_models/test_list_card_model.dart';
import 'package:eng_questions/datas/local_storages/question_db_manager.dart';
import 'package:eng_questions/datas/local_storages/user_db_manager.dart';
import 'package:eng_questions/datas/models/storage_models/question_storage_models/question_storage_model.dart';
import 'package:eng_questions/datas/models/storage_models/user_storage_models/user_storage_model.dart';

class LocalStorageRepository {
  late UserDbManager userManager;
  late QuestionDbManager questionManager;

  LocalStorageRepository() {
    userManager = UserDbManager();
    questionManager = QuestionDbManager();
  }

  Future<UserStorageModel?> getUser() async {
    await userManager.init();
    var _model = userManager.getFist();
    return _model;
  }

  Future<int?> addUser(UserStorageModel model) async {
    try {
      await userManager.init();
      var _model = await userManager.addItem(model);
      return _model;
    } catch (e) {
      throw e;
    }
  }

  LogOutUsers() async {
    await userManager.init();
    await userManager.clearAll();
    await questionManager.init();
    await questionManager.clearAll();
  }

  Future<TestListCardModel> calculateUserScore(int testID) async {
    try {
      var user = await getUser();

      await questionManager.init();
      var model = await questionManager.calculateUserScore(testID, user!.key);
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<QuestionStepperComponentModel> calculateTestScore(int testID) async {
    try {
      var user = await getUser();

      await questionManager.init();
      var model = await questionManager.calculateTestScore(testID, user!.key);
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<int?> questionAnswer(QuestionStorageModel model) async {
    try {
      var user = await getUser();

      if (user == null) return -1;
      await questionManager.init();
      model.userId = user.key;
      return questionManager.questionAnswered(model);
    } catch (e) {
      throw e;
    }
  }

  Future<void> resetTest(int testID) async {
    try {
      var user = await getUser();
      if (user != null) {
        await questionManager.init();
        await questionManager.resetTest(testID, user.key);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<ChartModel>> getChatData() async {
    try {
      var user = await getUser();
      await questionManager.init();
      return await questionManager.prepareChartModel(user!.key);
    } catch (e) {
      throw e;
    }
  }

  Future<void> closeAllBox() async {
    await questionManager.closeBox();
    await userManager.closeBox();
  }
}
