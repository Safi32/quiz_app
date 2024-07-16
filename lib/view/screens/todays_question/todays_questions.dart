import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/widgets/free_test_answers.dart';
import 'package:quiz_app/widgets/progress_line.dart';

class TodaysQuestions extends StatelessWidget {
  static const routeName = "TodaysQuestions";
  const TodaysQuestions({super.key});

  final double _progress = 0.1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Today's Question"),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.What action is to be taken by the Database Specialist to simulate a failure event?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FreeTestAnswers(
                        title: "He should use AWS DMS.",
                      ),
                      FreeTestAnswers(
                        title: "He should use AWS DMS.",
                      ),
                      FreeTestAnswers(
                        title: "He should use AWS DMS.",
                      ),
                      FreeTestAnswers(
                        title: "He should use AWS DMS.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProgressLine(
              width: MediaQuery.of(context).size.width,
              progress: _progress,
              innerColor: const Color.fromARGB(124, 255, 0, 0),
              outerColor: primaryColor,
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.bookmark_border,
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
