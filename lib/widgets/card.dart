import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatefulWidget {
  final String title;
  final bool showIcon;
  final Color color;
  final bool showToggle;
  final bool initialToggleState;
  final bool showText;
  final bool datePicker; 

  const CardWidget({
    required this.title,
    this.showIcon = true,
    required this.color,
    this.showToggle = false,
    this.initialToggleState = false,
    this.showText = false,
    this.datePicker = false,
    super.key,
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
              Row(
                children: [
                  if (widget.showText && !widget.datePicker)
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Exam-style',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (widget.datePicker)
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Row(
                        children: [
                          if (widget.showText)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Exam-style',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Text(
                            DateFormat.yMMMd().format(selectedDate),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
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
            ],
          ),
        ),
      ),
    );
  }
}
