import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class QuizModel with ChangeNotifier {
  int? _selectedDuration;
  int? _selectedQuestionCount;
  List<Map<String, dynamic>> _questions = [];
  int _currentQuestionIndex = 0;
  int _remainingTime = 0;
  Map<String, String?> _selectedOptions = {}; // Track selected options

  int? get selectedDuration => _selectedDuration;
  int? get selectedQuestionCount => _selectedQuestionCount;
  int get remainingTime => _remainingTime;
  Map<String, dynamic> get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : {};

  void setDuration(int? duration) {
    _selectedDuration = duration;
    notifyListeners();
  }

  void setQuestionCount(int? count) {
    _selectedQuestionCount = count;
    notifyListeners();
  }

  void startQuiz() {
    _remainingTime = _selectedDuration ?? 0;
    _fetchQuestions();
    _currentQuestionIndex = 0;
    _startTimer();
    notifyListeners();
  }

  void _fetchQuestions() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('timed_quiz').get();
    _questions = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'question': data['question'] ?? '',
        'options': {
          'a': data['a'] ?? '',
          'b': data['b'] ?? '',
          'c': data['c'] ?? '',
          'd': data['d'] ?? '',
        }
      };
    }).toList();
    notifyListeners();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
        // Handle timer end
        notifyListeners();
      }
    });
  }

  void nextQuestion() {
    if (_currentQuestionIndex < (_questions.length - 1)) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void selectOption(String option) {
    _selectedOptions[_currentQuestionIndex.toString()] = option;
    notifyListeners();
  }

  String? getSelectedOption() {
    return _selectedOptions[_currentQuestionIndex.toString()];
  }
}
