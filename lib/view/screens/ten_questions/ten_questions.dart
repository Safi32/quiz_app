import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/ten_quick_controller.dart';
import 'package:quiz_app/model/ten_quick_question.dart';
import 'package:quiz_app/provider/free_test_provider.dart';
import 'package:quiz_app/utils/colors.dart';

class TenQuestions extends StatelessWidget {
  static const routeName = "10questions";

  @override
  Widget build(BuildContext context) {
    return Consumer<TenQuestionsController>(
      builder: (context, tenQuestionsController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Consumer<OptionProvider>(
              builder: (context, provider, child) {
                return Text(
                  'Question ${provider.currentIndex + 1}/10',
                );
              },
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: StreamBuilder<List<TenQuickQuestion>>(
            stream: tenQuestionsController.fetchQuestions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No questions available'));
              }

              final questions = snapshot.data!.take(10).toList();
              final currentIndex =
                  Provider.of<OptionProvider>(context).currentIndex;
              final question = questions[currentIndex];
              final selectedOption = Provider.of<OptionProvider>(context)
                  .getSelectedOption(currentIndex);

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Q${currentIndex}: ${question.question}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: question.options.map((option) {
                              final isSelected = option == selectedOption;
                              return GestureDetector(
                                onTap: () {
                                  Provider.of<OptionProvider>(context,
                                          listen: false)
                                      .selectOption(currentIndex, option);
                                },
                                child: Card(
                                  color:
                                      isSelected ? Colors.blue : Colors.white,
                                  elevation: 1.0,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (Provider.of<OptionProvider>(context).currentIndex ==
                      questions.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleSubmit(context, questions);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_sharp),
                          onPressed: Provider.of<OptionProvider>(context)
                                      .currentIndex >
                                  0
                              ? () {
                                  Provider.of<OptionProvider>(context,
                                          listen: false)
                                      .goToPreviousQuestion();
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {
                            _saveMissedQuestion(question);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: Provider.of<OptionProvider>(context)
                                      .currentIndex <
                                  questions.length - 1
                              ? () {
                                  Provider.of<OptionProvider>(context,
                                          listen: false)
                                      .goToNextQuestion();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _handleSubmit(
      BuildContext context, List<TenQuickQuestion> questions) async {
    final unansweredQuestions = questions
        .where((question) =>
            Provider.of<OptionProvider>(context, listen: false)
                .getSelectedOption(questions.indexOf(question)) ==
            null)
        .toList();

    if (unansweredQuestions.isNotEmpty) {
      final shouldContinue = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Unanswered Questions'),
            content: const Text(
                'You have unanswered questions. Are you sure you want to continue?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          );
        },
      );

      if (shouldContinue ?? false) {
        _saveMissedQuestions(unansweredQuestions);
        Navigator.pushNamed(context, '/missed-questions');
      }
    } else {
      Navigator.pushNamed(context, '/missed-questions');
    }
  }

  void _saveMissedQuestion(TenQuickQuestion question) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('missed_questions').add({
        'question': question.question,
        'options': question.options,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving missed question: $e');
    }
  }

  void _saveMissedQuestions(List<TenQuickQuestion> missedQuestions) async {
    final firestore = FirebaseFirestore.instance;
    try {
      for (var question in missedQuestions) {
        await firestore.collection('missed_questions').add({
          'question': question.question,
          'options': question.options,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving missed questions: $e');
    }
  }
}
