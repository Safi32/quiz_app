import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/mcq_controller.dart';
import 'package:quiz_app/model/mcqs_model.dart';
import 'package:quiz_app/provider/free_test_provider.dart';
import 'package:quiz_app/utils/colors.dart'; // Import your colors

class FreeTest extends StatelessWidget {
  static const routeName = '/free-test';

  @override
  Widget build(BuildContext context) {
    final topicName = ModalRoute.of(context)?.settings.arguments as String?;
    final mcqController = Provider.of<MCQController>(context);
    final optionProvider = Provider.of<OptionProvider>(context);

    if (topicName == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Free Test'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const Center(
          child: Text(
            'Please Select a Topic',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Consumer<OptionProvider>(
          builder: (context, provider, child) {
            return Text(
              'Question ${provider.currentIndex + 1}/${provider.totalQuestions}',
            );
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<List<MCQ>>(
        stream: mcqController.fetchQuestions(topicName),
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

          final mcqs = snapshot.data!;
          final currentIndex = optionProvider.currentIndex;
          final mcq = mcqs[currentIndex];
          final selectedOption = optionProvider.getSelectedOption(currentIndex);

          optionProvider.setTotalQuestions(mcqs.length);

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
                            "Q${currentIndex + 1}: ${mcq.question}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: mcq.options.map((option) {
                          final isSelected = option == selectedOption;
                          return GestureDetector(
                            onTap: () {
                              optionProvider.selectOption(currentIndex, option);
                            },
                            child: Card(
                              color: isSelected ? Colors.blue : Colors.white,
                              elevation: 1.0,
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
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
              if (optionProvider.currentIndex == mcqs.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleSubmit(context, mcqs, optionProvider);
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                      ),
                      onPressed: optionProvider.currentIndex > 0
                          ? () {
                              optionProvider.goToPreviousQuestion();
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {
                        _saveMissedQuestion(mcq);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      onPressed: optionProvider.currentIndex < mcqs.length - 1
                          ? () {
                              optionProvider.goToNextQuestion();
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
  }

  Future<void> _handleSubmit(BuildContext context, List<MCQ> mcqs,
      OptionProvider optionProvider) async {
    final unansweredQuestions = mcqs
        .where((mcq) =>
            optionProvider.getSelectedOption(mcqs.indexOf(mcq)) == null)
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

  void _saveMissedQuestion(MCQ mcq) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('missed_questions').add({
        'question': mcq.question,
        'options': mcq.options,
        'correctAnswer': mcq.answer,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving missed question: $e');
    }
  }

  void _saveMissedQuestions(List<MCQ> missedQuestions) async {
    final firestore = FirebaseFirestore.instance;
    try {
      for (var mcq in missedQuestions) {
        await firestore.collection('missed_questions').add({
          'question': mcq.question,
          'options': mcq.options,
          'correctAnswer': mcq.answer,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving missed questions: $e');
    }
  }
}
