import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'translate_screen.dart';
import 'learn_screen.dart';
import 'favorites_screen.dart';
import 'chat_screen.dart';
import 'videos_screen.dart';
import 'quiz_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) {
    final username = AuthService.instance.currentUser?.username ?? 'Estudante';
    return Scaffold(
      appBar: AppBar(title: Text('Olá, $username! 👋', style: const TextStyle(color: AppTheme.textDark)), actions: [IconButton(icon: const Icon(Icons.logout, color: Colors.grey), onPressed: () { AuthService.instance.logout(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen())); })]),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TranslateScreen())), child: Container(height: 110, decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(16)), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, color: Colors.white, size: 28), SizedBox(height: 8), Text('Tradutor Câmera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])))),
          const SizedBox(width: 16),
          Expanded(child: GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LearnScreen())), child: Container(height: 110, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xFFE2E8F0))), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.menu_book, color: AppTheme.primary, size: 28), SizedBox(height: 8), Text('Aulas Práticas', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold))])))),
        ]),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xFFE2E8F0))),
          child: Row(children: [
            const Icon(Icons.analytics_outlined, color: AppTheme.secondary, size: 40),
            const SizedBox(width: 16),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Seu Progresso: 65%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              SizedBox(height: 4),
              Text('40 aulas concluídas de 62', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
            ])
          ]),
        ),
        const SizedBox(height: 28),
        const Text('Acesso Rápido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        const SizedBox(height: 16),
        GridView.count(crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: [
          _item(context, Icons.favorite, 'Favoritos', const FavoritesScreen()),
          _item(context, Icons.chat, 'Chat IA', const ChatScreen()),
          _item(context, Icons.video_library, 'Vídeos', const VideosScreen()),
          _item(context, Icons.extension, 'Quiz', const QuizScreen()),
        ])
      ])),
    );
  }
  Widget _item(BuildContext context, IconData icon, String label, Widget target) {
    return GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => target)), child: Column(children: [CircleAvatar(backgroundColor: AppTheme.secondary.withOpacity(0.1), child: Icon(icon, color: AppTheme.primary)), const SizedBox(height: 8), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.textDark))]));
  }
}
