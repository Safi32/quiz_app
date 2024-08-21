import 'package:flutter/foundation.dart';

class OptionProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _totalQuestions = 0;
  final Map<int, String?> _selectedOptions = {};

  int get currentIndex => _currentIndex;
  int get totalQuestions => _totalQuestions;

  String? getSelectedOption(int index) => _selectedOptions[index];

  void selectOption(int index, String option) {
    _selectedOptions[index] = option;
    notifyListeners();
  }

  void goToNextQuestion() {
    _currentIndex++;
    notifyListeners();
  }

  void goToPreviousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void setTotalQuestions(int total) {
    _totalQuestions = total;
    notifyListeners();
  }
}
