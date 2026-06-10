import 'package:flutter/material.dart';
import 'category_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'Animais', 'icon': '🐶'},
      {'name': 'Frutas', 'icon': '🍎'},
      {'name': 'Cores', 'icon': '🟩'},
      {'name': 'Números', 'icon': '1️⃣'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias de Sinais')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Card(
            child: ListTile(
              leading: Text(cat['icon']!, style: const TextStyle(fontSize: 32)),
              title: Text(cat['name']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CategoryScreen(categoryName: cat['name']!)),
              ),
            ),
          );
        },
      ),
    );
  }
}
