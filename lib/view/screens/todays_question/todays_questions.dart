import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/todays_question_controller.dart';
import 'package:quiz_app/model/todays_question.model.dart';
import 'package:quiz_app/utils/colors.dart';

class TodaysQuestions extends StatelessWidget {
  static const routeName = "TodaysQuestions";
  const TodaysQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodaysQuestionController(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 30,
                    ),
                    child: Text(
                      "Today's Questions",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<TodaysQuestionController>(
                  builder: (context, controller, _) {
                    return StreamBuilder<List<TodaysQuestionModel>>(
                      stream: controller.getTodaysQuestionsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error fetching questions'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No questions available'));
                        }

                        final questions = snapshot.data!;
                        controller.setQuestions(questions);

                        return ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            final questionData = questions[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Question:",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        questionData.question ?? 'No question',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        "Answer:",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        questionData.answer ?? 'No answer',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
