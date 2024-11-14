import 'package:flutter/material.dart';

class QuizResults extends StatelessWidget {
  final String nickname;
  final int correctAnswers;
  final int score;
  final int totalQuestions;
  final Function resetQuiz;

  QuizResults({
    required this.nickname,
    required this.correctAnswers,
    required this.score,
    required this.totalQuestions,
    required this.resetQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/final.png', height: 200),
          SizedBox(height: 20),
          Text(
            '🎉 Parabéns, $nickname! Você concluiu o quiz! 🎉',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Você acertou $correctAnswers de $totalQuestions questões.',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'Sua pontuação: $score',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            child: Text('Reiniciar Quiz'),
          ),
        ],
      ),
    );
  }
}
