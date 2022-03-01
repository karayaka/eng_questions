import 'package:eng_questions/datas/controllers/topic_controller.dart';
import 'package:get/get.dart';

class TopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopicController(
          service: Get.find(),
        ));
  }
}
