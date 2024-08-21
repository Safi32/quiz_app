import 'package:flutter/material.dart';

import 'package:quiz_app/view/screens/questions/questions.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({
    required this.question,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
