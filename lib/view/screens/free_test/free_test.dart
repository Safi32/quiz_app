import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/free_test_provider.dart';

class FreeTest extends StatelessWidget {
  static const routeName = "FreeTest";

  final List<String> questions =
      List.generate(30, (index) => "Question ${index + 1}");
  final List<List<String>> answers = List.generate(
    30,
    (index) => [
      "Answer 1 for Question ${index + 1}",
      "Answer 2 for Question ${index + 1}",
      "Answer 3 for Question ${index + 1}",
      "Answer 4 for Question ${index + 1}",
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FreeTestProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<FreeTestProvider>(
            builder: (context, provider, child) {
              return Text(
                "Question ${provider.currentQuestionIndex + 1}/30",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.more_vert_outlined,
              ),
            ),
          ],
        ),
        body: Consumer<FreeTestProvider>(
          builder: (context, provider, child) {
            final currentQuestion = questions[provider.currentQuestionIndex];
            final currentAnswers = answers[provider.currentQuestionIndex];
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    currentQuestion,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: currentAnswers.length,
                    itemBuilder: (context, index) {
                      final isSelected = provider.isAnswerSelected(index);
                      return GestureDetector(
                        onTap: () {
                          provider.selectAnswer(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.white,
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            currentAnswers[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: provider.previousQuestion,
                        child: const Icon(
                          Icons.arrow_back_ios_new_sharp,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: provider.nextQuestion,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
