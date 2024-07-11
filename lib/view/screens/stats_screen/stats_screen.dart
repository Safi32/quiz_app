import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/progress.dart';
import 'package:quiz_app/widgets/progress_line.dart';
import 'package:quiz_app/widgets/progress_report.dart';

class CurvedLoadingBar extends StatefulWidget {
  final double value;
  final int size;
  final Color color;

  const CurvedLoadingBar({
    Key? key,
    required this.value,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  _CurvedLoadingBarState createState() => _CurvedLoadingBarState();
}

class _CurvedLoadingBarState extends State<CurvedLoadingBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvedLoadingBarPainter(widget.value, widget.size, widget.color),
      child: const SizedBox(
        width: 200,
        height: 100,
      ),
    );
  }
}

class CurvedLoadingBarPainter extends CustomPainter {
  final double progress;
  final int circleSize;
  final Color color;

  CurvedLoadingBarPainter(this.progress, this.circleSize, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / circleSize, size.height);
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = pi;
    double sweepAngle = pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CurvedLoadingBarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

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
                color: Colors.orange,
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
                color: Colors.orange,
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
          const Expanded(
            child: Stack(
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
                            value: 0.1,
                            size: 2,
                            color: Colors.orange,
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
                            color: Color.fromARGB(120, 255, 153, 0),
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
                  child: Stack(
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
                            value: 2,
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
