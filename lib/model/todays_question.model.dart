import 'package:cloud_firestore/cloud_firestore.dart';

class TodaysQuestionModel {
  String? question;
  String? answer;
  Timestamp? timestamp;

  TodaysQuestionModel({
    this.question,
    this.answer,
    this.timestamp,
  });

  // Convert a Firestore document to TodaysQuestionModel
  factory TodaysQuestionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodaysQuestionModel(
      question: data['Question'] as String?,
      answer: data['Answer'] as String?,
      timestamp: data['timestamp'] as Timestamp?,
    );
  }

  // Convert TodaysQuestionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Question': question,
      'Answer': answer,
      'timestamp': timestamp,
    };
  }
}
