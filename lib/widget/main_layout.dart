import 'package:app_template/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admob/banner_ad_widget.dart';
import 'custom_indicator.dart';

class MainLayout extends StatefulWidget {
  final String logoText;
  final Widget settingMenu;
  final Widget body;
  final int currentIndex;
  final Function(int)? onTap;
  final List<BottomNavigationBarItem>? bottomNavItems;

  const MainLayout({
    super.key,
    required this.logoText,
    required this.settingMenu,
    required this.body,
    this.currentIndex = 0,
    this.onTap,
    this.bottomNavItems,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late LoadingState loadingState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadingState = Provider.of<LoadingState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final hasBottomNav = widget.bottomNavItems != null && widget.bottomNavItems!.isNotEmpty;

    return SafeArea(
      child: Consumer<LoadingState>(
        builder: (context, loadingStateValue, child) => Stack(
          children: [
            Scaffold(
              backgroundColor: AppColor.mainWhite,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.logoText,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Spacer()
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => widget.settingMenu));
                      //   },
                      //   child: Icon(Icons.settings, color: Colors.grey),
                      // )
                    ],
                  ),
                ),
              ),
              body: widget.body,
              bottomNavigationBar: hasBottomNav
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 배너 광고 위젯
                  const BannerAdWidget(),
                  // BottomNavigationBar
                  BottomNavigationBar(
                    currentIndex: widget.currentIndex,
                    onTap: widget.onTap,
                    items: widget.bottomNavItems!,
                  ),
                ],
              )
                  : null,
            ),
            // 로딩 인디케이터
            if (loadingStateValue.isLoading)
              Container(
                color: Colors.black.withAlpha(128),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: SizedBox(
                    width: 240,
                    height: 240,
                    child: CustomIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}