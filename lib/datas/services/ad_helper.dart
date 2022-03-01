import 'dart:io';

class AdHelper {
  static String get levelBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1229600046040111/2835934796';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get topicBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1229600046040111/4256827672';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get testBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1229600046040111/5282451963';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get questionBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1229600046040111/4159752614';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get questionInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1229600046040111/2265406388';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get questionRewardInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1229600046040111/3586226913';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }
}
