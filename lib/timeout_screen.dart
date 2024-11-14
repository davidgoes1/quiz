import 'package:flutter/material.dart';

class TimeoutScreen extends StatelessWidget {
  final Function resetQuiz;

  TimeoutScreen({required this.resetQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/tempo.jpg', height: 200),
          SizedBox(height: 200),
          Text(
            '⏰ O tempo acabou! ⏰',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            child: Text('Reiniciar o Quiz', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
