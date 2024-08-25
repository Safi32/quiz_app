import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/random_question_controller.dart';
import 'package:quiz_app/model/random_question.dart';
import 'package:quiz_app/utils/colors.dart';

class RandomQuestions extends StatelessWidget {
  static const routeName = "randomQuestion";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RandomQuestionsController(),
      child: Consumer<RandomQuestionsController>(
        builder: (context, controller, child) {
          final currentIndex = controller.currentIndex;
          final questions = controller.questions;
          final totalQuestions = questions.length;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Question ${currentIndex + 1}/$totalQuestions',
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: StreamBuilder<List<RandomQuestion>>(
              stream: controller.fetchRandomQuestions(),
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

                // Set questions to controller if not already set
                if (controller.questions.isEmpty) {
                  controller.setQuestions(snapshot.data!);
                }

                final currentQuestion =
                    controller.questions[controller.currentIndex];
                final selectedOption =
                    controller.getSelectedOption(controller.currentIndex);

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
                                  "Q${controller.currentIndex + 1}: ${currentQuestion.question}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: currentQuestion.options.map((option) {
                                final isSelected = option == selectedOption;
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectOption(
                                        controller.currentIndex, option);
                                  },
                                  child: Card(
                                    color:
                                        isSelected ? Colors.blue : Colors.white,
                                    elevation: 1.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4.0),
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
                    if (controller.currentIndex == totalQuestions - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement submit logic here if required
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
                            onPressed: controller.currentIndex > 0
                                ? () {
                                    controller.previousQuestion();
                                  }
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.bookmark_border),
                            onPressed: () {
                              controller.bookmarkQuestion();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Question bookmarked')),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_outlined),
                            onPressed:
                                controller.currentIndex < totalQuestions - 1
                                    ? () {
                                        controller.nextQuestion();
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
      ),
    );
  }
}
