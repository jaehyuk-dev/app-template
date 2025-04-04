import 'dart:ui';

class AppColor{
  static Color mainWhite = Color(0xFFf0f1f2);
  static Color mainBlack = Color(0xFF000000);
}

class AdMob{
  static final String appId = "ca-app-pub-3293874374616393~5841748953";

  static final String? appOpeningId = null;
  static final String? adaptiveBannerId = null;
  static final String? bannerId = null;
  static final String? interstitialId = null;
  static final String? rewardedId = null;
  static final String? rewardedInterstitialId = null;
  static final String? nativeId = null;
  static final String? nativeVideoId = null;

  // 테스트 광고 ID 모음
  static const testAds = TestAds();
}

// 테스트 광고 ID 클래스
class TestAds {
  const TestAds();

  final String appOpening = "ca-app-pub-3940256099942544/9257395921";
  final String adaptiveBanner = "ca-app-pub-3940256099942544/9214589741";
  final String banner = "ca-app-pub-3940256099942544/6300978111";
  final String interstitial = "ca-app-pub-3940256099942544/1033173712";
  final String rewarded = "ca-app-pub-3940256099942544/5224354917";
  final String rewardedInterstitial = "ca-app-pub-3940256099942544/5354046379";
  final String native = "ca-app-pub-3940256099942544/2247696110";
  final String nativeVideo = "ca-app-pub-3940256099942544/1044960115";
}