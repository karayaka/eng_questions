import 'package:eng_questions/core/component_models/chart_model.dart';
import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/models/service_models/dashbord_model.dart';
import 'package:eng_questions/datas/models/storage_models/user_storage_models/user_storage_model.dart';
import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:eng_questions/datas/services/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends BaseController {
  late ServiceRepository service;
  late LocalStorageRepository storage;

  @override
  void onReady() {
    super.onReady();
    getDashbord();
    getDastbortChart();
    createBannerAd();
  }

  var user = UserStorageModel().obs;
  var dashbord = DashbordModel();
  List<ChartModel> series = [];

  var isLoading = true.obs;

  var chartsLoding = false.obs;
  var isAdLoaded = false.obs;
  late BannerAd bannerAd;

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

  createBannerAd() {
    bannerAd = BannerAd(
        adUnitId: AdHelper.homeBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (_) {
          isAdLoaded.value = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
  }
}
