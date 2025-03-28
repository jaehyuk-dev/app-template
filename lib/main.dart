import 'package:app_template/screen/main_screen.dart';
import 'package:app_template/service/loading_service.dart';
import 'package:app_template/widget/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/admob_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 앱 최초 실행 시 AdMob 설정 (한 번만 실행)
  bool isFirstRun = await checkIfFirstRun();
  if (isFirstRun) {
    // AdMob 설정 자동화 실행
    await AdMobConfig.setupAdMob();
    // 첫 실행 상태 저장
    await saveFirstRunCompleted();
  }

  await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Template',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) {
          // 앱이 시작될 때 LoadingService 초기화
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingService.init(context);
          });
          return MainScreen();
        },
      ),
    );
  }
}

// 최초 실행 여부를 확인하는 함수 (shared_preferences 등을 사용하여 구현)
Future<bool> checkIfFirstRun() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('first_run') ?? true;
}

// 첫 실행 완료 상태를 저장하는 함수
Future<void> saveFirstRunCompleted() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('first_run', false);
}

