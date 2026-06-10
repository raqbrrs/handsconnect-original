import 'package:flutter/material.dart';
import '../data/signs_data.dart';
import '../widgets/sign_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favSigns = mockSigns.take(2).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Seus Favoritos')),
      body: favSigns.isEmpty
          ? const Center(child: Text('Nenhum sinal favoritado ainda.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favSigns.length,
              itemBuilder: (context, index) => SignCard(sign: favSigns[index], isFavorite: true),
            ),
    );
  }
}
