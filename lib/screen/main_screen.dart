import 'package:app_template/widget/main_layout.dart';
import 'package:flutter/material.dart';

import '../service/loading_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // 네비게이션 아이템 선택 시 호출되는 함수
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // 다른 화면으로 이동할 콘텐츠 준비
  final List<Widget> _screens = [
    const Center(child: Text('홈 화면')),
    const Center(child: Text('검색 화면')),
    const Center(child: Text('설정 화면')),
  ];

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
      body: _screens[_currentIndex],
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      bottomNavItems: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ],
    );
  }
}