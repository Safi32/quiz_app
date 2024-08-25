import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/todays_question.model.dart';

class TodaysQuestionController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TodaysQuestionModel? currentQuestion;

  TodaysQuestionController() {
    _initializeQuestion();
  }

  // Method to initialize the question and set a timer for updates
  void _initializeQuestion() async {
    final questionsStream = getTodaysQuestionsStream();
    questionsStream.listen((questions) {
      if (questions.isNotEmpty) {
        final latestQuestion = _getLatestQuestion(questions);
        _setCurrentQuestion(latestQuestion);
      }
    });

    // Set a timer to remove the question after an hour
    Future.delayed(const Duration(hours: 24), () {
      _clearCurrentQuestion();
    });
  }

  // Stream to listen for real-time updates
  Stream<List<TodaysQuestionModel>> getTodaysQuestionsStream() {
    return _firestore.collection('todays_question').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodaysQuestionModel.fromFirestore(doc);
      }).toList();
    });
  }

  TodaysQuestionModel _getLatestQuestion(List<TodaysQuestionModel> questions) {
    questions.sort((a, b) {
      return b.timestamp!.compareTo(a.timestamp!);
    });
    return questions.first;
  }

  void _setCurrentQuestion(TodaysQuestionModel question) {
    currentQuestion = question;
    notifyListeners();
  }

  void _clearCurrentQuestion() {
    currentQuestion = null;
    notifyListeners();
  }

  // Function to add a new question with an automatic timestamp
  Future<void> addQuestion(String question, String answer) async {
    await _firestore.collection('todays_question').add({
      'Question': question,
      'Answer': answer,
      'timestamp': Timestamp.now(),
    });
  }
}
