  import 'package:flutter/material.dart';
  import 'package:lottie/lottie.dart';
  import 'package:flutter/services.dart' as s;
  import 'package:xml/xml.dart';
  import 'Quizmodel.dart';

  class VyQuiz extends StatefulWidget {
    late final String category;
    VyQuiz({required this.category});
    @override
    State<VyQuiz> createState() => _VyQuizState();
  }

  Future<List<QuizQuestion>> loadQuizData(String category) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate delay
    final xmlString = await s.rootBundle.loadString('assets/vector/Questions.xml');
    final document = XmlDocument.parse(xmlString);
    final questions = <QuizQuestion>[];

    // Filter questions with id="flutter"
    final QuestionsSet = document.findAllElements('question').where((question) => question.getAttribute('id') == category);

    for (var questionElement in QuestionsSet) {
      final questionText = questionElement.findElements('text').single.text;
      final options = questionElement.findElements('option').map((e) => e.text).toList();
      final correctOption = int.parse(questionElement.findElements('correct').single.text);

      questions.add(QuizQuestion(
        question: questionText,
        options: options,
        correctOption: correctOption,
      ));
    }

    questions.shuffle();
    final randomQuestions = questions.take(10).toList();
    return randomQuestions;
  }


  class _VyQuizState extends State<VyQuiz> {
    late Future<List<QuizQuestion>> _quizQuestions;

    @override
    void initState() {
      super.initState();
      _quizQuestions = loadQuizData(widget.category);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Quiz Screen')),
        body: FutureBuilder<List<QuizQuestion>>(
          future: _quizQuestions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      Lottie.asset(
                        "assets/vector/shimmer.json",
                      ),
                      Lottie.asset(
                        "assets/vector/shimmer.json",
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading quiz data'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No quiz data available'));
            } else {
              return QuizScreen(questions: snapshot.data!);
            }
          },
        ),
      );
    }
  }
