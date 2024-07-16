import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/free_test/free_test.dart';
import 'package:quiz_app/view/screens/missed_questions/missed_questions.dart';
import 'package:quiz_app/view/screens/random_questions/random_questions.dart';
import 'package:quiz_app/view/screens/saved_questions/save_question.dart';
import 'package:quiz_app/view/screens/setting_screen/setting_screen.dart';
import 'package:quiz_app/view/screens/subscription_screen/subscription_screen.dart';
import 'package:quiz_app/view/screens/ten_questions/ten_questions.dart';
import 'package:quiz_app/view/screens/timed_quiz/timed_quiz.dart';
import 'package:quiz_app/view/screens/todays_question/todays_questions.dart';
import 'package:quiz_app/widgets/quiz_modes.dart';

void main() {
  runApp(
    const HomePage(),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "Study",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SettingScreen.routeName);
                    },
                    child: const Icon(
                      Icons.settings,
                      color: primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SubscriptionScreen.routeName);
                  },
                  child: const Text(
                    "Unlock all questions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, FreeTest.routeName);
                  },
                  child: const Text(
                    "Take a free test",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "Quiz Modes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QuizModes(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TodaysQuestions.routeName);
                          },
                          icon: Icons.add_to_photos_outlined,
                          title: "Today's \n Question",
                          color: Colors.green,
                        ),
                        QuizModes(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TenQuestions.routeName);
                          },
                          icon: Icons.web_stories_outlined,
                          title: "10 Questions \n Quick Quiz",
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QuizModes(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MissedQuestions.routeName);
                          },
                          icon: Icons.add_to_photos_outlined,
                          title: "Missed \n Questions \n Quiz",
                          color: Colors.red,
                        ),
                        QuizModes(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SaveQuestion.routeName);
                          },
                          icon: Icons.bookmark_add_outlined,
                          title: "Saved \n Question \n Quiz",
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        QuizModes(
                          onPressed: () {
                            Navigator.pushNamed(context, TimedQuiz.routeName);
                          },
                          icon: Icons.access_time_sharp,
                          title: "Timed Quiz",
                          color: Colors.purple,
                        ),
                        QuizModes(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RandomQuestions.routeName);
                          },
                          icon: Icons.autorenew_sharp,
                          title: "Random \n Set Quiz",
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
