import 'package:eng_questions/core/component_models/chart_model.dart';
import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/models/service_models/dashbord_model.dart';
import 'package:eng_questions/datas/models/storage_models/user_storage_models/user_storage_model.dart';
import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeController extends BaseController {
  late ServiceRepository service;
  late LocalStorageRepository storage;

  @override
  void onReady() {
    super.onReady();
    getDashbord();
    getDastbortChart();
  }

  var user = UserStorageModel().obs;
  var dashbord = DashbordModel();
  List<ChartModel> series = [];

  var isLoading = true.obs;

  var chartsLoding = false.obs;

  HomeController({
    required this.service,
    required this.storage,
  });

  getDashbord() async {
    try {
      var sesion = await storage.getUser();
      if (sesion != null) {
        user.value = sesion;
      }
      var model =
          prepareServiceModel<DashbordModel>(await service.getDashbord());
      if (model != null) {
        dashbord = model;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage(e.toString());
    }
  }

  getDastbortChart() async {
    try {
      chartsLoding.value = true;
      series = await storage.getChatData();
      chartsLoding.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage(e.toString());
    }
  }
}
