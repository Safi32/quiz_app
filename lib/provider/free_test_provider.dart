import 'package:flutter/material.dart';

class FreeTestProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};

  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, int> get selectedAnswers => _selectedAnswers;

  void selectAnswer(int answerIndex) {
    _selectedAnswers[_currentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < 29) {
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

  bool isAnswerSelected(int answerIndex) {
    return _selectedAnswers[_currentQuestionIndex] == answerIndex;
  }
}
