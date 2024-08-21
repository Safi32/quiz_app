// lib/model/random_question.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class RandomQuestion {
  final String question;
  final List<String> options;

  RandomQuestion({
    required this.question,
    required this.options,
  });

  factory RandomQuestion.fromMap(Map<String, dynamic> data) {
    return RandomQuestion(
      question: data['Question'] ?? '',
      options: [
        data['a'] ?? '',
        data['b'] ?? '',
        data['c'] ?? '',
        data['d'] ?? '',
      ],
    );
  }
}
