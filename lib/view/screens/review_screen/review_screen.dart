import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/widgets/questions.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _page = 0;
  int _text = 0; // Tracks selected tab index
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMMM d').format(DateTime.now());

  final List<String> questions = [
    "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the",
    "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the",
    "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the",
    "While performing the compliance procedure, a Database Specialist requires to conduct fault testing on an Amazon RDS for MySQL running in the",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 70,
              left: 30,
            ),
            child: Text(
              "Review",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _page = 0;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      color: _page == 0 ? Colors.white : Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "Quizzes",
                        style: TextStyle(
                          color: _page == 0 ? Colors.orange : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _page = 1;
                      _text =
                          0; // Reset to default tab "All" when switching to Questions
                    });
                  },
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _page == 1 ? Colors.white : Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "Questions",
                        style: TextStyle(
                          color: _page == 1 ? Colors.orange : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (_page == 0) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.query_stats_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Quizzes",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Add navigation or action
                          },
                          child: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "0 %",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your time - 00:24",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Average time 31:30",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_page == 1) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _text = 0;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "All",
                            style: TextStyle(
                              color: _text == 0
                                  ? Colors.orange
                                  : Colors.orange.shade300,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (_text == 0)
                          Positioned(
                            bottom: -2,
                            child: Container(
                              height: 2.5,
                              width: 20,
                              color: Colors.orange,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _text = 1;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Correct",
                            style: TextStyle(
                              color: _text == 1
                                  ? Colors.orange
                                  : Colors.orange.shade300,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (_text == 1)
                          Positioned(
                            bottom: -2,
                            child: Container(
                              height: 2.5,
                              width: 50,
                              color: Colors.orange,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _text = 2;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Incorrect",
                            style: TextStyle(
                              color: _text == 2
                                  ? Colors.orange
                                  : Colors.orange.shade300,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (_text == 2)
                          Positioned(
                            bottom: -2,
                            child: Container(
                              height: 2.5,
                              width: 60,
                              color: Colors.orange,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_text == 1) {
                    return questions[index].contains("conduct fault testing")
                        ? const Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  } else if (_text == 2) {
                    return questions[index].contains("conduct fault testing")
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              QuestionsScreen(
                                questions: questions[index],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                  } else {
                    return Column(
                      children: [
                        QuestionsScreen(
                          questions: questions[index],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
