import 'package:flutter/material.dart';

class QuizModes extends StatelessWidget {
  const QuizModes({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
    required this.color,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 1.2,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
