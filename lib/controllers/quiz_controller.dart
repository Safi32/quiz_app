import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/quiz_model.dart';

class QuizController {
  static void setDuration(BuildContext context, int? duration) {
    Provider.of<QuizModel>(context, listen: false).setDuration(duration);
  }

  static void setQuestionCount(BuildContext context, int? count) {
    Provider.of<QuizModel>(context, listen: false).setQuestionCount(count);
  }

  static void startQuiz(BuildContext context) {
    Provider.of<QuizModel>(context, listen: false).startQuiz();
  }

  static void nextQuestion(BuildContext context) {
    Provider.of<QuizModel>(context, listen: false).nextQuestion();
  }

  static void previousQuestion(BuildContext context) {
    Provider.of<QuizModel>(context, listen: false).previousQuestion();
  }

  static void selectOption(BuildContext context, String option) {
    Provider.of<QuizModel>(context, listen: false).selectOption(option);
  }
}
