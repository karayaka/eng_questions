import 'package:eng_questions/app_tools/tools.dart';
import 'package:eng_questions/datas/models/base_models/base_result.dart';
import 'package:eng_questions/datas/models/service_models/dashbord_model.dart';
import 'package:eng_questions/datas/models/service_models/level_model.dart';
import 'package:eng_questions/datas/models/service_models/question_model,.dart';
import 'package:eng_questions/datas/models/service_models/test_model.dart';
import 'package:eng_questions/datas/models/service_models/topic_model.dart';
import 'package:eng_questions/datas/services/base_service.dart';

class ServiceRepository {
  Future<BaseResult> getLevels({int page = 1}) async {
    BaseResult model = (await BaseService.instance!.dioGet<LevelModel>(
        "/QuizerMobil/GetLevel/all/$page/", LevelModel(),
        token: Tools.appToken));
    return model;
  }

  Future<BaseResult> getDashbord() async {
    BaseResult model = await BaseService.instance!.dioGet(
        "/QuizerMobil/MobilDasbord", DashbordModel(), //dashbord url verilecek
        token: Tools.appToken);

    return model;
  }

  Future<BaseResult> getTopics({int page = 1, int levelID = 0}) async {
    BaseResult model = (await BaseService.instance!.dioGet<TopicModel>(
        "/QuizerMobil/GetTopic/all/$page/$levelID", TopicModel(),
        token: Tools.appToken));
    return model;
  }

  Future<BaseResult> getTests({int page = 1, int topicID = 0}) async {
    BaseResult model = (await BaseService.instance!.dioGet<TestModel>(
        "/QuizerMobil/GetTest/all/$page/$topicID", TestModel(),
        token: Tools.appToken));
    return model;
  }

  Future<BaseResult> getQuestion(
      {int questionNumber = 1, int testID = 0}) async {
    BaseResult model = (await BaseService.instance!.dioGet<QuestionModel>(
        "/QuizerMobil/GetQuestion/$testID/$questionNumber", QuestionModel(),
        token: Tools.appToken));
    return model;
  }
}
