import 'package:flutter/material.dart';
import '../data/signs_data.dart';
import '../widgets/sign_card.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final filteredSigns = mockSigns.where((s) => s.category == categoryName).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Sinais: $categoryName')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredSigns.length,
        itemBuilder: (context, index) {
          final sign = filteredSigns[index];
          return SignCard(
            sign: sign,
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                builder: (_) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(sign.imageUrl, style: const TextStyle(fontSize: 64)),
                      const SizedBox(height: 12),
                      Text(sign.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(sign.description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
