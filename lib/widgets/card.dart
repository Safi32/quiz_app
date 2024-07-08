import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final bool showIcon;
  final Color color;
  final bool showToggle;
  final bool initialToggleState;

  const CardWidget({
    required this.title,
    this.showIcon = true,
    required this.color,
    this.showToggle = false,
    this.initialToggleState = false,
    super.key,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isToggle = false;

  @override
  void initState() {
    super.initState();
    isToggle = widget.initialToggleState;
  }

  void toggleSwitch(bool newValue) {
    setState(() {
      isToggle = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
              if (widget.showIcon)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              if (widget.showToggle)
                Switch(
                  value: isToggle,
                  onChanged: toggleSwitch,
                  activeColor: Colors.grey,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
