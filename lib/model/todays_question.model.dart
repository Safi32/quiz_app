import 'package:cloud_firestore/cloud_firestore.dart';

class TodaysQuestionModel {
  String? question;
  String? answer;

  TodaysQuestionModel({
    required this.question,
    required this.answer,
  });

  // Convert a Firestore document to TodaysQuestionModel
  factory TodaysQuestionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodaysQuestionModel(
      question: data['Question'] as String?,
      answer: data['Answer'] as String?,
    );
  }

  // Convert TodaysQuestionModel to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Question'] = question;
    data['Answer'] = answer;
    return data;
  }
}
