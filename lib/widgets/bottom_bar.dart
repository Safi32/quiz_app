import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final void Function(int)? onTap;
  final List<Widget>? screens;
  final int? selectedIndex;

  const BottomBar({Key? key, this.onTap, this.screens, this.selectedIndex})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
  }

  void onBtnClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.screens![_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes,
            ),
            label: "Study",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stacked_line_chart_sharp,
            ),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.reviews,
            ),
            label: "Review",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onBtnClick,
        selectedItemColor: Colors.orange,
        unselectedItemColor: const Color.fromARGB(110, 255, 153, 0),
      ),
    );
  }
}
