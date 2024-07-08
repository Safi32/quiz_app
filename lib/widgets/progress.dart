import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({super.key, required this.color, required this.percentage});

  final Color color;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          percentage,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
