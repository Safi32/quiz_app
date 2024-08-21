// lib/controllers/ten_questions_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/ten_quick_question.dart';

class TenQuestionsController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Stream<List<TenQuickQuestion>> fetchQuestions() {
    return _firestore
        .collection('ten_quick_questions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TenQuickQuestion.fromFirestore(doc))
          .toList();
    });
  }

  void goToPreviousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void goToNextQuestion() {
    _currentIndex++;
    notifyListeners();
  }
}
