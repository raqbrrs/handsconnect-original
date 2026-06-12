# 2. ATUALIZANDO A TELA PRINCIPAL (lib/screens/home_screen.dart)
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

  @override
  Widget build(BuildContext context) {
    final username = AuthService.instance.currentUser?.username ?? 'Raquel';
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $username! 👋'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.textLight),
            onPressed: () {
              AuthService.instance.logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha com os dois botões principais do topo do seu design
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TranslateScreen())),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_rounded, color: Colors.white, size: 32),
                          SizedBox(height: 8),
                          Text('Tradutor Câmera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LearnScreen())),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.secondary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book_rounded, color: AppTheme.primary, size: 32),
                          SizedBox(height: 8),
                          Text('Aulas Práticas', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            
            // Card de Progresso igual ao layout limpo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_rounded, color: AppTheme.primary, size: 36),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Seu Progresso Atual', style: TextStyle(fontSize: 14, color: AppTheme.textLight, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text('65% Concluído', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                        const SizedBox(height: 2),
                        const Text('40 aulas concluídas de 62', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            const Text('Acesso Rápido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 16),
            
            // Grid de Botões Quadrados arredondados
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _buildGridItem(context, Icons.favorite_rounded, 'Favoritos', const FavoritesScreen()),
                _buildGridItem(context, Icons.forum_rounded, 'Chat IA', const ChatScreen()),
                _buildGridItem(context, Icons.play_circle_fill_rounded, 'Vídeos', const VideosScreen()),
                _buildGridItem(context, Icons.extension_rounded, 'Quiz', const QuizScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label, Widget target) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => target)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.primary, size: 28),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          ],
        ),
      ),
    );
  }
}
