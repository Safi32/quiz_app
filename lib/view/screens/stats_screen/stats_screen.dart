import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/widgets/curved_loading_bar.dart';
import 'package:quiz_app/widgets/progress.dart';
import 'package:quiz_app/widgets/progress_line.dart';
import 'package:quiz_app/widgets/progress_report.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final double _progress = 0.2;
  final List<Map<String, String>> progressReport = [
    {"title": "Tests taken", "number": "1"},
    {"title": "Longest streak", "number": "1 day"},
    {"title": "Answered questions", "number": "30"},
    {"title": "Correct answers", "number": "0"},
    {"title": "Solutions Architect-Associate", "number": "0%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Row(
              children: [
                Text(
                  "Stats",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current pass rate",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "5%",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ProgressLine(
                      progress: _progress,
                      innerColor: const Color.fromARGB(132, 255, 255, 255),
                      outerColor: Colors.white,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Test taken",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                "Correct answers",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                "Questions taken",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Progress(
                color: primaryColor,
                percentage: "6%",
              ),
              Progress(
                color: Colors.lightBlue,
                percentage: "0%",
              ),
              Progress(
                color: Colors.blue,
                percentage: "6%",
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: const Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 100,
                          child: CurvedLoadingBar(
                            value: 0.2,
                            size: 2,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          height: 100,
                          child: CurvedLoadingBar(
                            value: 1,
                            size: 1,
                            color: Color.fromARGB(120, 255, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                        child: SizedBox(
                          width: 170,
                          height: 68,
                          child: CurvedLoadingBar(
                            value: 0,
                            size: 2,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 170,
                          height: 68,
                          child: CurvedLoadingBar(
                            value: 1,
                            size: 2,
                            color: Color.fromARGB(120, 0, 102, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Stack(
                    children: [
                      Align(
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: CurvedLoadingBar(
                            value: 0.1,
                            size: 2,
                            color: Color.fromARGB(255, 0, 102, 255),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: CurvedLoadingBar(
                            value: 1,
                            size: 1,
                            color: Color.fromARGB(120, 47, 0, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: progressReport.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ProgressReport(
                      title: progressReport[index]['title']!,
                      number: progressReport[index]['number']!,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
