import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _likes = 24;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comunidade Hands Connect')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(child: Text('AL')),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Aline Lima', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Há 2 horas', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Gente, finalmente consegui entender as nuances das expressões faciais na aula de hoje! Faz toda a diferença no sinal 🤟. Alguém aí quer praticar via chamada hoje à noite?', style: TextStyle(fontSize: 15)),
                  const Divider(height: 24),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(_isLiked ? Icons.thumb_up : Icons.thumb_up_outlined, color: _isLiked ? AppTheme.primary : AppTheme.textLight),
                        onPressed: () => setState(() {
                          _isLiked = !_isLiked;
                          _isLiked ? _likes++ : _likes--;
                        }),
                      ),
                      Text('$_likes curtidas'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
