import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/services/notification_service.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;

class SplashController extends BaseController {
  late LocalStorageRepository localStorageRepository;

  SplashController({required this.localStorageRepository});

  @override
  void onInit() async {
    await Hive.initFlutter();
    await NotificationService.init();
    await MobileAds.instance.initialize();
    await PlatformViewsService.synchronizeToNativeViewHierarchy(false);
    tz.initializeTimeZones();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    var user = await localStorageRepository.getUser();
    if (user == null) {
      Get.offAndToNamed(RouteConst.login);
    } else {
      Get.offAndToNamed(RouteConst.home);
    }
  }
}
