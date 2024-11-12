import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
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
    });
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
    });
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
        _feedbackMessage = 'Falso! Você errou.';
      }
      _isAnswerSelected = true;
    });
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswerSelected = false;
        _feedbackMessage = '';
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startQuiz,
            child: Text('Começar o Quiz', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizQuestion() {
    final question = _questions[_currentQuestionIndex];

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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...List.generate(question['options'].length, (index) {
            return ElevatedButton(
              onPressed: _isAnswerSelected
                  ? null
                  : () => _answerQuestion(index),
              child: Text(question['options'][index]),
            );
          }),
          SizedBox(height: 20),
          Text(
            'Pontuação: $_score',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          if (_feedbackMessage.isNotEmpty)
            Text(
              _feedbackMessage,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _isAnswerCorrect ? Colors.green : Colors.red),
            ),
          SizedBox(height: 20),
          if (_isAnswerSelected)
            ElevatedButton(
              onPressed: _goToNextQuestion,
              child: Text('Próxima Pergunta', style: TextStyle(fontSize: 18)),
            ),
        ],
      ),
    );
  }

  Widget _buildFinalScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/final.png',
            height: 400,
          ),
          SizedBox(height: 20),
          Text(
            '🎉 Parabéns, você concluiu o quiz! 🎉',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Você acertou $_correctAnswers de ${_questions.length} perguntas.',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Text(
            'Pontuação Total: $_score',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _resetQuiz,
            child: Text('Tentar Novamente', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Naruto')),
      body: _quizStarted
          ? _quizCompleted
              ? _buildFinalScreen()
              : _buildQuizQuestion()
          : _buildStartPage(),
    );
  }
}
