import 'package:eng_questions/datas/controllers/question_controller.dart';
import 'package:get/get.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionContoller(
          service: Get.find(),
          storage: Get.find(),
        ));
  }
}
