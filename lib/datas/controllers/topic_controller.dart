import 'package:eng_questions/datas/controllers/base_cotrollers/base_controller.dart';
import 'package:eng_questions/datas/services/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/datas/models/service_models/topic_model.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:get/get.dart';

class TopicController extends BaseController {
  late ServiceRepository service;

  TopicController({required this.service});

  @override
  void onReady() {
    super.onReady();
    final int? s = Get.arguments;
    if (s != null) {
      levelID = s;
    }
    getTopics();
    createBannerAd();
  }

  var levelID = 0;
  int _pageID = 1;
  var pageLoding = false.obs;
  var nextPageLoding = false;
  List<TopicModel> topics = [];

  var isAdLoaded = false.obs;
  late BannerAd bannerAd;

  createBannerAd() {
    bannerAd = BannerAd(
        adUnitId: AdHelper.topicBannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (_) {
          isAdLoaded.value = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));
    bannerAd.load();
  }

  Future<void> getTopics() async {
    try {
      pageLoding.value = true;
      var model = prepareServiceModel<List<TopicModel>>(
          await service.getTopics(levelID: levelID));
      if (model != null) {
        topics = model;
      }
      pageLoding.value = false;
    } catch (e) {
      pageLoding.value = false;
      errorMessage(e.toString());
    }
  }

  getTopicsNextPage() async {
    try {
      if (_pageID > pageCount) return;
      _pageID++;
      nextPageLoding = true;
      update(["loding"]);
      var model = prepareServiceModel<List<TopicModel>>(
          await service.getTopics(page: _pageID, levelID: levelID));
      nextPageLoding = false;
      if (model != null) {
        topics.addAll(model);
      }
      update(["loding"]);
    } catch (e) {
      nextPageLoding = false;
      errorMessage(e.toString());
      update(["loding"]);
    }
  }

  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }
}
