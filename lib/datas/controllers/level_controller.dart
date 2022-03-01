import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/services/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/datas/models/service_models/level_model.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:get/get.dart';

class LevelController extends BaseController {
  late ServiceRepository services;

  LevelController({
    required this.services,
  });

  @override
  void onReady() async {
    await getLevels();
    createBannerAd();
    super.onReady();
  }

  var listLoading = false.obs;
  var nextPageLoading = false.obs;
  List<LevelModel> levels = [];
  int pageNumber = 1;
  var isAdLoaded = false.obs;
  late BannerAd bannerAd;

  createBannerAd() {
    bannerAd = BannerAd(
        adUnitId: AdHelper.levelBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (_) {
          isAdLoaded.value = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
  }

  getLevels() async {
    try {
      listLoading.value = true;
      var model =
          prepareServiceModel<List<LevelModel>>(await services.getLevels());
      if (model != null) {
        levels = model;
      }
      listLoading.value = false;
    } catch (e) {
      listLoading.value = false;
      errorMessage(e.toString());
    }
  }

  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }
}
