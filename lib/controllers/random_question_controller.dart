// lib/controllers/random_question_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/random_question.dart';

class RandomQuestionsController extends ChangeNotifier {
  int _currentIndex = 0;
  List<RandomQuestion> _questions = [];
  final Map<int, String?> _selectedOptions = {}; // Track selected options

  int get currentIndex => _currentIndex;
  List<RandomQuestion> get questions => _questions;
  String? getSelectedOption(int index) => _selectedOptions[index];

  Stream<List<RandomQuestion>> fetchRandomQuestions() {
    return FirebaseFirestore.instance
        .collection('Random_question')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => RandomQuestion.fromMap(doc.data()))
            .toList());
  }

  void setQuestions(List<RandomQuestion> questions) {
    _questions = questions;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void selectOption(int index, String option) {
    _selectedOptions[index] = option;
    notifyListeners();
  }

  void bookmarkQuestion() {
    // Add bookmark logic here
  }
}
