import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final bool showIcon;
  final Color color;
  final bool showToggle;
  final bool initialToggleState;
  final bool showText;
  final bool datePicker;

  final Widget? subtitle;
  final VoidCallback? onPressed;

  const CardWidget({
    super.key,
    required this.title,
    this.showIcon = true,
    required this.color,
    this.showToggle = false,
    this.initialToggleState = false,
    this.showText = false,
    this.datePicker = false,
    this.subtitle,
    this.onPressed,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isToggle = false;
  DateTime selectedDate = DateTime.now();

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

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap:
              widget.datePicker ? () => _selectDate(context) : widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.showText &&
                        !widget.datePicker &&
                        widget.subtitle == null)
                      const Text(
                        'Exam-style',
                        style: TextStyle(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (widget.subtitle != null) widget.subtitle!,
                    if (widget.datePicker)
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Row(
                          children: [
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    const SizedBox(
                      width: 10,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
