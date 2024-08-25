import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/utils/colors.dart';

class TimedQuiz extends StatelessWidget {
  static const routeName = "timedQuiz";

  const TimedQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close),
        ),
      ),
      body: Consumer<QuizModel>(
        builder: (context, quizModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (quizModel.remainingTime > 0) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    'Time Remaining: ${quizModel.remainingTime} seconds',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Expanded(
                child: quizModel.remainingTime > 0
                    ? quizModel.currentQuestion.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quizModel.currentQuestion['question'] ?? '',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 20),
                                ..._buildOptions(context,
                                    quizModel.currentQuestion['options'] ?? {}),
                              ],
                            ),
                          )
                        : const Center(
                            child: Text(
                              'No Questions Available',
                              style: TextStyle(fontSize: 24),
                            ),
                          )
                    : Center(
                        child: ElevatedButton(
                          onPressed: () => _showQuizDialog(context),
                          child: const Text('Start Quiz'),
                        ),
                      ),
              ),
              if (quizModel.isLastQuestion && quizModel.remainingTime > 0)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      if (quizModel.getSelectedOption() != null) {
                        _submitQuiz(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please select an option before submitting.'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit Quiz',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_sharp),
                      onPressed: () {
                        QuizController.previousQuestion(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        QuizController.nextQuestion(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showQuizDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    'Select Duration and Number of Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<int>(
                hint: const Text(
                  'Select Duration (seconds)',
                  style: TextStyle(color: Colors.black),
                ),
                onChanged: (int? newValue) {
                  QuizController.setDuration(context, newValue);
                },
                items: List.generate(61, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(index.toString()),
                  );
                }),
              ),
              const SizedBox(height: 20),
              DropdownButton<int>(
                hint: const Text(
                  'Select Number of Questions',
                  style: TextStyle(color: Colors.black),
                ),
                onChanged: (int? newValue) {
                  QuizController.setQuestionCount(context, newValue);
                },
                items: List.generate(16, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(index.toString()),
                  );
                }),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Start Quiz',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                QuizController.startQuiz(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildOptions(
      BuildContext context, Map<String, dynamic> options) {
    return options.entries.map((entry) {
      final isSelected =
          Provider.of<QuizModel>(context, listen: true).getSelectedOption() ==
              entry.key;
      return Card(
        color: isSelected ? Colors.blue : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ListTile(
          title: Text('${entry.key.toUpperCase()}: ${entry.value}'),
          onTap: () {
            QuizController.selectOption(context, entry.key);
          },
        ),
      );
    }).toList();
  }

  void _submitQuiz(BuildContext context) {
    // Implement quiz submission logic here
    print('Quiz Submitted!');
  }
}
