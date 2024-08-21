// lib/model/ten_quick_question.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TenQuickQuestion {
  final String question;
  final List<String> options;

  TenQuickQuestion({
    required this.question,
    required this.options,
  });

  factory TenQuickQuestion.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TenQuickQuestion(
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
