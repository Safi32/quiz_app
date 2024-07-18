import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/questions/questions.dart';
import 'package:quiz_app/widgets/question_card.dart';

class TenQuestions extends StatelessWidget {
  static const routeName = "10questions";
  TenQuestions({super.key});

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
        appBar: AppBar(
          title: const Text(
            "Question 1/10",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
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
                    "Ten Quick Questions",
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
