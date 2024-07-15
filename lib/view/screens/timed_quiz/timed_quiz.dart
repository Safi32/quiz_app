import 'dart:async';

import 'package:flutter/material.dart';

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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
          title: const Text('Select Time and Question'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: Text(selectedTime == null
                    ? 'Select Time'
                    : 'Time: ${selectedTime!.format(context)}'),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                hint: const Text('Select Question'),
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
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
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
        title: const Text('Quiz App'),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
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
