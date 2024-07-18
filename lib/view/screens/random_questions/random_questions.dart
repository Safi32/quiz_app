import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/questions/questions.dart';
import 'package:quiz_app/widgets/question_card.dart';

class RandomQuestions extends StatelessWidget {
  static const routeName = "randomQuestion";
  RandomQuestions({super.key});

  final List<Question> question = [
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
    Question(
      question:
          "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the Multi-AZ deployments configuration.",
      answer:
          "The test will assess the resiliency of the database in the event of DB instance failure and availability zone disruption.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Random Questions",
          ),
          centerTitle: true,
          elevation: 0,
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
                    "Random Question",
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
              child: ListView.builder(
                itemCount: question.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      QuestionCard(question: question[index]),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
