import 'dart:async';
import 'package:flutter/material.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctOption;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOption,
  });
}

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  QuizScreen({required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  Map<int, int?> selectedOptions = {};
  int totalCorrectAnswers = 0;
  bool quizCompleted = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds:10), (timer) {
      setState(() {
        if (_currentQuestionIndex < 9) {
          _currentQuestionIndex++;
        } else {
          timer.cancel();
          calculateTotalCorrectAnswers();
          quizCompleted = true;
        }
      });
    });
  }

  void calculateTotalCorrectAnswers() {
    int correctAnswers = 0;
    for (int i = 0; i < 10; i++) {
      if (selectedOptions[i] == widget.questions[i].correctOption) {
        correctAnswers++;
      }
    }
    setState(() {
      totalCorrectAnswers = correctAnswers;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!quizCompleted) {
      final currentQuestion = widget.questions[_currentQuestionIndex];

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentQuestion.question, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                ...currentQuestion.options.asMap().entries.map((entry) {
                  final optionIndex = entry.key;
                  final optionText = entry.value;
                  return ListTile(
                    title: Text(optionText),
                    leading: Radio<int>(
                      activeColor: Colors.teal,
                      value: optionIndex,
                      groupValue: selectedOptions[_currentQuestionIndex],
                      onChanged: (int? value) {
                        setState(() {
                          selectedOptions[_currentQuestionIndex] = value;
                        });
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      );
    } else {
      // Display total correct answers
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Correct Answers: $totalCorrectAnswers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }
}
