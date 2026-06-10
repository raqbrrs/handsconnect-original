import 'package:flutter/material.dart';
import '../data/videos_data.dart';
import '../theme/app_theme.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vídeoaulas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockVideos.length,
        itemBuilder: (context, index) {
          final video = mockVideos[index];
          return Card(
            child: ListTile(
              leading: Icon(
                video.isLocked ? Icons.lock : Icons.play_circle_fill,
                color: video.isLocked ? AppTheme.textLight : AppTheme.secondary,
                size: 36,
              ),
              title: Text(video.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${video.level} • ${video.duration}'),
              onTap: () {
                if (video.isLocked) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Conteúdo Bloqueado'),
                      content: const Text('Conclua os módulos anteriores do quiz para desbloquear esta aula avançada.'),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendido'))],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Iniciando: ${video.title}')));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
