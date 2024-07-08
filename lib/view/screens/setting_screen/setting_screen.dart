import 'package:flutter/material.dart';
import 'package:quiz_app/view/screens/review_screen/review_screen.dart';
import 'package:quiz_app/view/screens/side_bar/side_bar.dart';
import 'package:quiz_app/view/screens/stats_screen/stats_screen.dart';
import 'package:quiz_app/widgets/bottom_bar.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = "SettingScreen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    const Sidebar(),
    const StatsScreen(),
    const ReviewScreen(),
  ];

  void onBtnClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomBar(
          onTap: onBtnClick,
          screens: screens,
          selectedIndex: _selectedIndex,
        ),
        body: screens[_selectedIndex],
      ),
    );
  }
}
