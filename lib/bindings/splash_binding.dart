import 'package:eng_questions/datas/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(localStorageRepository: Get.find()));
  }
}
