import 'package:eng_questions/datas/controllers/test_controller.dart';
import 'package:get/get.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestController(
          service: Get.find(),
          storage: Get.find(),
        ));
  }
}
