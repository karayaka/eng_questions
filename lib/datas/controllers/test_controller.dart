import 'package:eng_questions/core/component_models/test_list_card_model.dart';
import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/models/service_models/test_model.dart';
import 'package:eng_questions/datas/services/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:get/get.dart';

class TestController extends BaseController {
  late ServiceRepository service;
  late LocalStorageRepository storage;
  TestController({
    required this.service,
    required this.storage,
  });

  @override
  void onReady() {
    super.onReady();
    final int? s = Get.arguments;
    if (s != null) {
      topicID = s;
    }
    getTest();
    _createInterstitialAd();
    createBannerAd();
  }

  @override
  void dispose() async {
    await storage.closeAllBox();
    interstitialAd?.dispose();
    super.dispose();
  }

  var pageLoding = false.obs;
  var nextPageLoding = false;
  int topicID = 0;
  int _pageID = 1;
  List<TestModel> tests = [];
  var isBannerAdLoaded = false.obs;
  late BannerAd bannerAd;

  createBannerAd() {
    bannerAd = BannerAd(
        adUnitId: AdHelper.testBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (_) {
          isBannerAdLoaded.value = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
  }

  InterstitialAd? interstitialAd;
  int interstitialAdError = 0;


  void showIterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      });
      interstitialAd!.show();
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.questionInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          interstitialAdError = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          interstitialAdError++;
          interstitialAd = null;
          if (interstitialAdError <= 3) {
            _createInterstitialAd();
          }
        }));
  }

  Future<void> getTest() async {
    try {
      pageLoding.value = true;
      var model = prepareServiceModel<List<TestModel>>(
          await service.getTests(topicID: topicID));
      if (model != null) {
        tests = model;
      }
      pageLoding.value = false;
    } catch (e) {
      pageLoding.value = false;
      errorMessage(e.toString());
    }
  }

  getTestNextPage() async {
    try {
      if (_pageID > pageCount) return;
      _pageID++;
      nextPageLoding = true;
      update(["loding"]);
      nextPageLoding = true;
      var model = prepareServiceModel<List<TestModel>>(
          await service.getTests(page: _pageID, topicID: topicID));
      if (model != null) {
        tests.addAll(model);
      }
      nextPageLoding = false;
      update(["loding"]);
    } catch (e) {
      nextPageLoding = false;
      update(["loding"]);
      errorMessage(e.toString());
    }
  }

  Future<TestListCardModel?> getTestScores(TestModel model) async {
    try {
      var retVal = await storage.calculateUserScore(model.id!);

      retVal.questionCount = model.questionCount ?? 0;

      update(["item${model.id}"]);
      return retVal;
    } catch (e) {
      update(["item${model.id}"]);
      errorMessage(e.toString());
    }
  }

  Future restTest(TestModel model) async {
    try {
      await storage.resetTest(model.id ?? 0);
      Get.toNamed(RouteConst.questionDetail, arguments: {
        "adStatus": model.adsStatus,
        "testID": model.id,
        "lastNumber": 0
      });
    } catch (e) {
      errorMessage(e.toString());
    }
  }
}
