import 'package:flutter/material.dart';
import 'package:quiz_app/model/ten_quick_question.dart';

class QuickQuestion extends StatelessWidget {
  final TenQuickQuestion question;

  const QuickQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...question.options.map((option) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
