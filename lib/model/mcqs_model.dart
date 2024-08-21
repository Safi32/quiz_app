import 'package:cloud_firestore/cloud_firestore.dart';

class MCQ {
  final String question;
  final String answer;
  final List<String> options;

  MCQ({
    required this.question,
    required this.answer,
    required this.options,
  });

  factory MCQ.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return MCQ(
      question: data['Question'] ?? '',
      answer: data['Answer'] ?? '',
      options: [
        data['a'] ?? '',
        data['b'] ?? '',
        data['c'] ?? '',
        data['d'] ?? '',
      ],
    );
  }
}
