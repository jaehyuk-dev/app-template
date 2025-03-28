import 'package:app_template/widget/main_layout.dart';
import 'package:flutter/material.dart';
import '../service/loading_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  // 테스트용 비동기 함수
  void temp() async {
    await LoadingService.withLoading(() async {
      await Future.delayed(Duration(seconds: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      logoText: "App Template",
      settingMenu: Placeholder(),
      body: Center(
        child: ElevatedButton(
          onPressed: temp,
          child: Text('로딩 테스트'),
        ),
      ),
    );
  }
}