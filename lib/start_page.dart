import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  final Function startQuiz;
  final String nickname;
  final Function(String) onNicknameChanged;

  StartPage({
    required this.startQuiz,
    required this.nickname,
    required this.onNicknameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/inicio.jpg',
            height: 300,
          ),
          SizedBox(height: 20),
          Text(
            '🌀 Teste Seu Conhecimento sobre NARUTO! 🌀',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            onChanged: onNicknameChanged,
            decoration: InputDecoration(
              labelText: 'Digite seu nome',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: nickname.isEmpty ? null : () => startQuiz(),
            child: Text('Começar o Quiz', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
