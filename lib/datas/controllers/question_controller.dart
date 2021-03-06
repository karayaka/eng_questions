import 'package:eng_questions/core/component_models/question_stepper_component_model.dart';
import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/models/service_models/question_model,.dart';
import 'package:eng_questions/datas/models/storage_models/question_storage_models/question_storage_model.dart';
import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:get/get.dart';

class QuestionContoller extends BaseController {
  late ServiceRepository service;
  late LocalStorageRepository storage;
  QuestionContoller({
    required this.service,
    required this.storage,
  });

  int testID = 0;
  int adStatus = 0;
  int questionNumber = 1;
  var questionModel = QuestionModel();
  var testScore = QuestionStepperComponentModel();
  var questionLoding = false.obs;
  var scoreLoding = true.obs;

  @override
  void onReady() {
    super.onReady();
    var arg = Get.arguments;
    _injectParams(arg);
    getQuestion();
  }

  _injectParams(dynamic arg) {
    if (arg["testID"] != null) {
      testID = arg["testID"];
    }
    if (arg["adStatus"] != null) {
      adStatus = arg["adStatus"];
    }
    if (arg["lastNumber"] != 0) {
      questionNumber = arg["lastNumber"] + 1;
    }
    print(questionNumber);
  }

  getQuestion() async {
    try {
      questionLoding.value = true;
      var model = await service.getQuestion(
          questionNumber: questionNumber, testID: testID);
      var retVal = prepareServiceModel<QuestionModel>(model);
      if (retVal != null) {
        questionModel = retVal;
      }
      getTestScores();
      questionLoding.value = false;
    } catch (e) {
      questionLoding.value = false;
      errorMessage(e.toString());
    }
  }

  getTestScores() async {
    try {
      scoreLoding.value = true;
      testScore = await storage.calculateTestScore(testID);
      testScore.questionCount = pageCount;
      testScore.questionNumber = questionNumber;
      scoreLoding.value = false;
    } catch (e) {
      scoreLoding.value = false;
      errorMessage(e.toString());
    }
  }

  //Kald??????nYerden Devam Etme Testi S??f??rmalam Yeniden ????zme ??zelikleri ekelencek
  questionAnsvered(int answerStatus) async {
    try {
      var model = QuestionStorageModel(
        answerDate: DateTime.now(),
        answerStatus: answerStatus,
        questionId: questionModel.id ?? 0,
        questionNumber: questionNumber,
        testId: testID,
        userId: 0,
      );

      storage.questionAnswer(model);
    } catch (e) {
      errorMessage(e.toString());
    }
  }

  nextQuestion() async {
    try {
      questionNumber++;
      await getQuestion();
    } catch (e) {
      errorMessage(e.toString());
    }
  }
}
