import 'package:app_template/widget/main_layout.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        logoText: "App Template",
        settingMenu: Placeholder(),
      body: Placeholder(),
    );
  }
}
