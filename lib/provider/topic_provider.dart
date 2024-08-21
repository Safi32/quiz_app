import 'package:flutter/material.dart';

class SelectedTopicProvider with ChangeNotifier {
  String? _selectedTopicId;

  String? get selectedTopicId => _selectedTopicId;

  void selectTopic(String topicId) {
    _selectedTopicId = topicId;
    notifyListeners();
  }
}
