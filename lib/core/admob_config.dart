// lib/core/admob/admob_config.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AdMobConfig {
  static const String defaultAppId = "ca-app-pub-3293874374616393~5841748953";

  // AndroidManifest.xml 파일에 AdMob ID를 업데이트하는 함수
  static Future<bool> setupAdMobInManifest({String? customAppId}) async {
    try {
      final String appId = customAppId ?? defaultAppId;

      // Android 플랫폼에서만 실행
      if (!Platform.isAndroid) {
        print('AdMob 설정은 Android 플랫폼에서만 적용됩니다.');
        return false;
      }

      // AndroidManifest.xml 파일 경로
      final manifestPath = 'android/app/src/main/AndroidManifest.xml';

      // 파일 읽기
      final File manifestFile = File(manifestPath);
      if (!await manifestFile.exists()) {
        print('AndroidManifest.xml 파일을 찾을 수 없습니다: $manifestPath');
        return false;
      }

      String manifestContent = await manifestFile.readAsString();

      // 이미 AdMob meta-data가 있는지 확인
      final bool hasAdMobMetaData = manifestContent.contains('com.google.android.gms.ads.APPLICATION_ID');

      if (hasAdMobMetaData) {
        // 기존 값을 업데이트
        final RegExp metaDataRegExp = RegExp(
            r'<meta-data\s+android:name="com.google.android.gms.ads.APPLICATION_ID"\s+android:value="[^"]*"\s*/>'
        );

        if (metaDataRegExp.hasMatch(manifestContent)) {
          manifestContent = manifestContent.replaceAll(
              metaDataRegExp,
              '<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="$appId"/>'
          );
        }
      } else {
        // 새로운 meta-data 태그 추가
        final int applicationTagCloseIndex = manifestContent.lastIndexOf('</application>');
        if (applicationTagCloseIndex != -1) {
          final String metaDataTag =
              '\n    <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="$appId"/>';

          manifestContent = manifestContent.substring(0, applicationTagCloseIndex) +
              metaDataTag +
              manifestContent.substring(applicationTagCloseIndex);
        }
      }

      // 변경된 내용을 파일에 쓰기
      await manifestFile.writeAsString(manifestContent);
      print('AdMob ID가 AndroidManifest.xml에 성공적으로 설정되었습니다: $appId');
      return true;
    } catch (e) {
      print('AdMob 설정 중 오류 발생: $e');
      return false;
    }
  }

  // build.gradle 파일에 필요한 종속성이 있는지 확인하고 추가하는 함수
  static Future<bool> setupAdMobDependencies() async {
    try {
      if (!Platform.isAndroid) {
        print('AdMob 종속성 설정은 Android 플랫폼에서만 적용됩니다.');
        return false;
      }

      // app/build.gradle 파일 경로
      final gradlePath = 'android/app/build.gradle';

      // 파일 읽기
      final File gradleFile = File(gradlePath);
      if (!await gradleFile.exists()) {
        print('build.gradle 파일을 찾을 수 없습니다: $gradlePath');
        return false;
      }

      String gradleContent = await gradleFile.readAsString();

      // 이미 AdMob 종속성이 있는지 확인
      final bool hasGmsAdsImport = gradleContent.contains("com.google.android.gms:play-services-ads");

      if (!hasGmsAdsImport) {
        // dependencies 블록 찾기
        final RegExp dependenciesRegExp = RegExp(r'dependencies\s*\{([^}]*)\}', multiLine: true);
        final Match? dependenciesMatch = dependenciesRegExp.firstMatch(gradleContent);

        if (dependenciesMatch != null) {
          final String dependenciesBlock = dependenciesMatch.group(1) ?? '';
          final String newDependenciesBlock = dependenciesBlock +
              "\n    implementation 'com.google.android.gms:play-services-ads:23.6.0'\n";

          gradleContent = gradleContent.replaceFirst(
              dependenciesRegExp,
              'dependencies {$newDependenciesBlock}'
          );

          // 변경된 내용을 파일에 쓰기
          await gradleFile.writeAsString(gradleContent);
          print('AdMob 종속성이 build.gradle에 성공적으로 추가되었습니다.');
        }
      } else {
        print('AdMob 종속성이 이미 build.gradle에 추가되어 있습니다.');
      }

      return true;
    } catch (e) {
      print('AdMob 종속성 설정 중 오류 발생: $e');
      return false;
    }
  }

  // 전체 AdMob 설정을 한번에 수행하는 함수
  static Future<bool> setupAdMob({String? customAppId}) async {
    try {
      bool dependenciesSetup = await setupAdMobDependencies();
      bool manifestSetup = await setupAdMobInManifest(customAppId: customAppId);

      return dependenciesSetup && manifestSetup;
    } catch (e) {
      print('AdMob 전체 설정 중 오류 발생: $e');
      return false;
    }
  }
}