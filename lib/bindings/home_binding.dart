import 'package:eng_questions/datas/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
          service: Get.find(),
          storage: Get.find(),
        ));
  }
}
