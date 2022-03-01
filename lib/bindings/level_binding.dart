import 'package:eng_questions/datas/controllers/level_controller.dart';
import 'package:get/get.dart';

class LevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LevelController(
          services: Get.find(),
        ));
  }
}
