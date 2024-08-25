import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class QuizModel with ChangeNotifier {
  int? _selectedDuration;
  int? _selectedQuestionCount;
  List<Map<String, dynamic>> _questions = [];
  List<Map<String, dynamic>> _filteredQuestions = []; // Filtered questions
  int _currentQuestionIndex = 0;
  int _remainingTime = 0;
  Map<String, String?> _selectedOptions = {}; // Track selected options

  int? get selectedDuration => _selectedDuration;
  int? get selectedQuestionCount => _selectedQuestionCount;
  int get remainingTime => _remainingTime;
  Map<String, dynamic> get currentQuestion =>
      _filteredQuestions.isNotEmpty ? _filteredQuestions[_currentQuestionIndex] : {};

  void setDuration(int? duration) {
    _selectedDuration = duration;
    notifyListeners();
  }

  void setQuestionCount(int? count) {
    _selectedQuestionCount = count;
    _filterQuestions(); // Update the filtered questions
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
    _filterQuestions(); // Filter questions after fetching
    notifyListeners();
  }

  void _filterQuestions() {
    if (_selectedQuestionCount != null) {
      _filteredQuestions = _questions.take(_selectedQuestionCount!).toList();
    } else {
      _filteredQuestions = _questions;
    }
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
    if (_currentQuestionIndex < (_filteredQuestions.length - 1)) {
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

  bool get isLastQuestion =>
      _filteredQuestions.isNotEmpty &&
      _currentQuestionIndex == _filteredQuestions.length - 1;

  void selectOption(String option) {
    _selectedOptions[_currentQuestionIndex.toString()] = option;
    notifyListeners();
  }

  String? getSelectedOption() =>
      _selectedOptions[_currentQuestionIndex.toString()];

  bool get hasSelectedOption =>
      getSelectedOption() != null;
}
