import 'package:flutter/material.dart';
import 'dart:async';
import 'start_page.dart';
import 'quiz_results.dart';
import 'timeout_screen.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  bool _quizStarted = false;
  bool _quizCompleted = false;
  bool _isAnswerCorrect = false;
  bool _isAnswerSelected = false;
  String _feedbackMessage = '';
  int _timeLeft = 15;
  late Timer _timer;
  bool _timeUp = false;
  String _nickname = '';

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Como é o nome do jutsu usado pelo 3º Hokage para aprisionar as mãos do Orochimaru?',
      'options': ['Hiraishin no Jutsu', 'Shinra Tensei.', 'Bakuton', 'Bola de Fogo'],
      'answer': 0,
      'image': 'lib/assets/01.PNG',
    },
    {
      'question': 'Até o final da saga de Naruto Shippuden, qual o Susanoo mais forte?',
      'options': ['Sasuke', 'Madara', 'Itachi', 'Kakashi'],
      'answer': 1,
      'image': 'lib/assets/02.jpg',
    },
    // Continue with the rest of your questions...
  ];

  void _startQuiz() {
    setState(() {
      _quizStarted = true;
      _quizCompleted = false;
      _score = 0;
      _correctAnswers = 0;
      _currentQuestionIndex = 0;
      _feedbackMessage = '';
      _isAnswerSelected = false;
      _timeLeft = 15;
      _timeUp = false;
    });
    _startTimer();
  }

  void _resetQuiz() {
    setState(() {
      _quizStarted = false;
      _quizCompleted = false;
      _score = 0;
      _correctAnswers = 0;
      _currentQuestionIndex = 0;
      _feedbackMessage = '';
      _isAnswerSelected = false;
      _timeLeft = 15;
      _timeUp = false;
      _nickname = ''; 
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _cancelTimer();
        setState(() {
          _timeUp = true;
        });
      }
    });
  }

  void _cancelTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _answerQuestion(int selectedOption) {
    bool isCorrect = selectedOption == _questions[_currentQuestionIndex]['answer'];
    setState(() {
      if (isCorrect) {
        _score += 10;
        _correctAnswers++;
        _isAnswerCorrect = true;
        _feedbackMessage = 'Verdadeiro! Você acertou.';
      } else {
        _isAnswerCorrect = false;
        _feedbackMessage = 'Falso! Você errou. A resposta correta é: ${_questions[_currentQuestionIndex]['options'][_questions[_currentQuestionIndex]['answer']]}';
      }
      _isAnswerSelected = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      _goToNextQuestion();
    });
  }

  void _goToNextQuestion() {
    if (_timeUp) {
      return;
    }

    _cancelTimer();
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswerSelected = false;
        _feedbackMessage = '';
        _timeLeft = 15;
      });
      _startTimer();
    } else {
      setState(() {
        _quizCompleted = true;
      });
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _quizStarted
          ? _quizCompleted
              ? QuizResults(nickname: _nickname, correctAnswers: _correctAnswers, score: _score, totalQuestions: _questions.length, resetQuiz: _resetQuiz)
              : _timeUp
                  ? TimeoutScreen(resetQuiz: _resetQuiz)
                  : _buildQuizQuestion()
          : StartPage(startQuiz: _startQuiz, nickname: _nickname, onNicknameChanged: (value) {
              setState(() {
                _nickname = value;
              });
            }),
    );
  }

  Widget _buildQuizQuestion() {
    final question = _questions[_currentQuestionIndex];
    Color progressColor = _timeLeft <= 5 ? Colors.red : Colors.orange;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            question['image'],
            height: 400,
          ),
          SizedBox(height: 20),
          Text(
            'Questão ${_currentQuestionIndex + 1}: ${question['question']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ...List.generate(question['options'].length, (index) {
            return ElevatedButton(
              onPressed: !_isAnswerSelected ? () => _answerQuestion(index) : null,
              child: Text(
                question['options'][index],
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
          }),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: _timeLeft / 15,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 8,
          ),
          SizedBox(height: 10),
          Text(
            'Tempo restante: $_timeLeft s',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: progressColor),
          ),
          SizedBox(height: 20),
          if (_isAnswerSelected)
            Text(
              _feedbackMessage,
              style: TextStyle(
                color: _isAnswerCorrect ? Colors.green : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
