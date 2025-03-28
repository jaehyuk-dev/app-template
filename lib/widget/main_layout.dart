import 'package:app_template/core/constants.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final String logoText;
  final Widget settingMenu;
  final Widget body;

  const MainLayout({
    super.key,
    required this.logoText,
    required this.settingMenu,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
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
                      logoText,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => settingMenu));
                      },
                      child: Icon(Icons.settings, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            body: body,
            bottomNavigationBar: null,
          ),
        ],
      ),
    );
  }
}
