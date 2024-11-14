import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme(
          primary: Colors.orange,
          secondary: Colors.deepPurple,
          surface: Colors.white,
          background: Colors.transparent,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple,
        ),
      ),
      home: QuizPage(),
    );
  }
}

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
    {
      'question': 'Depois do Madara e do Itachi, quem é o usuário mais forte de Mangekyō Sharingan?',
      'options': ['Itachi', 'Obito', 'Kakashi', 'Shisui'],
      'answer': 1,
      'image': 'lib/assets/03.png',
    },
    {
      'question': 'Depois do Madara, quem foi o primeiro a despertar o Mangekyō Sharingan?',
      'options': ['Obito', 'Kakashi', 'Shisui', 'Fugaku'],
      'answer': 2,
      'image': 'lib/assets/04.png',
    },
    {
      'question': 'Em quanto tempo Naruto aprendeu o Rasengan?',
      'options': ['1 semana', '1 mês', '2 semanas', '2 meses'],
      'answer': 0,
      'image': 'lib/assets/05.png',
    },
    {
      'question': 'Quem teve as notas mais altas da academia ninja da história?',
      'options': ['Minato', 'Itachi', 'Sasuke', 'Hashirama'],
      'answer': 0,
      'image': 'lib/assets/06.png',
    },
    {
      'question': 'Qual livro escrito por Jiraiya que Kakashi está sempre lendo?',
      'options': ['Jardim da Pegação', 'Jardim dos Amassos', 'Jardim da Felicidade', 'Jardim das Orgias'],
      'answer': 1,
      'image': 'lib/assets/07.png',
    },
    {
      'question': 'Qual o primeiro jutsu que o Naruto aprende?',
      'options': ['Clone das Sombras', 'Fuga de Cordas', 'Jutsu da Transformação', 'Rasengan'],
      'answer': 2,
      'image': 'lib/assets/08.png',
    },
    {
      'question': 'Como a Kaguya conseguiu ser a primeira humana a ter Chakra?',
      'options': ['Alguém deu para ela', 'Ela que criou o Chakra', 'Ela comeu a fruta da árvore sagrada', 'Hagoromo passou para ela o Chakra'],
      'answer': 2,
      'image': 'lib/assets/09.png',
    },
    {
      'question': 'Que cor é o Susanoo de Shisui?',
      'options': ['Verde', 'Roxo', 'Marrom', 'Azul Claro'],
      'answer': 0,
      'image': 'lib/assets/10.png',
    }
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

  Widget _buildStartPage() {
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
            onChanged: (value) {
              setState(() {
                _nickname = value;
              });
            },
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
            onPressed: _nickname.isEmpty ? null : _startQuiz,
            child: Text('Começar o Quiz', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
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
              onPressed: !_isAnswerSelected
                  ? () => _answerQuestion(index)
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
              ),
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

  Widget _buildTimeoutScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/tempo.jpg',
            height: 200,
          ),
          SizedBox(height: 200),
          Text(
            '⏰ O tempo acabou! ⏰',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetQuiz,
            child: Text('Reiniciar o Quiz', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/final.png',
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            '🎉 Parabéns, $_nickname! Você concluiu o quiz! 🎉',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Você acertou $_correctAnswers de ${_questions.length} questões.',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'Sua pontuação: $_score',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _resetQuiz,
            child: Text('Reiniciar Quiz'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _quizStarted
            ? _quizCompleted
                ? _buildQuizResults()
                : _timeUp
                    ? _buildTimeoutScreen()
                    : _buildQuizQuestion()
            : _buildStartPage(),
      ),
    );
  }
}
