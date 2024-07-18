import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';

class TimedQuiz extends StatefulWidget {
  static const routeName = "timedQuiz";
  const TimedQuiz({super.key});

  @override
  _TimedQuizState createState() => _TimedQuizState();
}

class _TimedQuizState extends State<TimedQuiz> {
  TimeOfDay? selectedTime;
  String? selectedQuestion;
  List<String> questions = [
    'Question 1',
    'Question 2',
    'Question 3',
    'Question 4',
  ];
  late Timer _timer;
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        _formattedTime = '${now.hour}:${now.minute}:${now.second}';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _showQuizDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Text(
                    'Select Time and Question',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: Text(
                  selectedTime == null
                      ? 'Select Time'
                      : 'Time: ${selectedTime!.format(context)}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                hint: const Text(
                  'Select Question',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: selectedQuestion,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedQuestion = newValue;
                  });
                },
                items: questions.map((String question) {
                  return DropdownMenuItem<String>(
                    value: question,
                    child: Text(question),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                if (selectedTime != null && selectedQuestion != null) {
                  print('Selected Time: ${selectedTime!.format(context)}');
                  print('Selected Question: $selectedQuestion');
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showQuizDialog,
          child: const Text('Start Quiz'),
        ),
      ),
    );
  }
}
