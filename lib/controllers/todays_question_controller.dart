import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/todays_question.model.dart';

class TodaysQuestionController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TodaysQuestionModel> todaysQuestions = [];

  // Stream to listen for real-time updates
  Stream<List<TodaysQuestionModel>> getTodaysQuestionsStream() {
    return _firestore.collection('todays_question').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodaysQuestionModel.fromFirestore(doc);
      }).toList();
    });
  }

  void setQuestions(List<TodaysQuestionModel> questions) {
    todaysQuestions = questions;
    notifyListeners();
  }
}
