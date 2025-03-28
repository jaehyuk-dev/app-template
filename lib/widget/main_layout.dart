import 'package:app_template/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_indicator.dart';

class MainLayout extends StatefulWidget {
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
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late LoadingState loadingState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the provider in didChangeDependencies instead of initState
    loadingState = Provider.of<LoadingState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<LoadingState>(
          builder: (context, loadingStateValue, child) =>
              Stack(
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => widget.settingMenu));
                              },
                              child: Icon(Icons.settings, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    body: widget.body,
                    bottomNavigationBar: null,
                  ),
                  // Add the loading indicator here
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
        )
    );
  }
}