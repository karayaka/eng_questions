import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/models/storage_models/user_storage_models/user_storage_model.dart';
import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/services/notification_service.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  late LocalStorageRepository storage;
  LoginController({required this.storage});

  var loading = false.obs;
  final loginKey = GlobalKey<FormState>();
  String userName = "";

  Login() async {
    if (loginKey.currentState!.validate()) {
      loading.value = true;
      await NotificationService.showPeriodicallyNotification(
        title: "İngilizce Sorular",
        body: "İngilizce Çalışmaya Nedersin",
        payload: "d",
      );
      var user = await storage.getUser();
      if (user != null) {
        storage.LogOutUsers();
      }
      var newUser = UserStorageModel(NameAndSurname: userName);
      var retval = await storage.addUser(newUser);
      loading.value = false;
      if (retval != null) {
        Get.offAllNamed(RouteConst.home);
      }
    }
  }
}
