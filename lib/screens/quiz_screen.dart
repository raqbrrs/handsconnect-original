import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _score = 0;
  bool _answered = false;
  String? _selectedOption;

  final String correctAnswer = 'Cachorro';
  final List<String> options = ['Gato', 'Cachorro', 'Leão', 'Passarinho'];

  void _checkAnswer(String option) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedOption = option;
      if (option == correctAnswer) _score += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Divertido')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(value: 0.25, backgroundColor: AppTheme.primaryLight),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pergunta 1 de 4', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Pontos: $_score', style: const TextStyle(color: AppTheme.secondary, fontWeight: FontWeight.bold)),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text('🐶\n\nQual é o significado deste sinal em Libras?', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),
            ...options.map((opt) {
              Color btnColor = Colors.white;
              if (_answered) {
                if (opt == correctAnswer) btnColor = Colors.green.shade200;
                if (opt == _selectedOption && opt != correctAnswer) btnColor = Colors.red.shade200;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: btnColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => _checkAnswer(opt),
                  child: Text(opt, style: const TextStyle(fontSize: 16, color: AppTheme.textDark)),
                ),
              );
            }),
            const SizedBox(height: 20),
            if (_answered) CustomButton(text: 'Próxima Pergunta', onPressed: () {
              setState(() {
                _answered = false;
                _selectedOption = null;
              });
            })
          ],
        ),
      ),
    );
  }
}
