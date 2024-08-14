import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/home_screen/home_screen.dart';
import 'package:quiz_app/view/screens/review_screen/review_screen.dart';
import 'package:quiz_app/view/screens/stats_screen/stats_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: "Study",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart_sharp),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart_sharp),
            label: "Stats",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
      body: _selectedIndex == 0
          ? const HomePage()
          : _selectedIndex == 1
              ? const StatsScreen()
              : _selectedIndex == 2
                  ? const ReviewScreen()
                  : const SizedBox(),
    );
  }
}
