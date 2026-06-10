import 'package:flutter/material.dart';
import '../data/signs_data.dart';
import '../widgets/sign_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final searchResults = mockSigns.where((s) => s.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Sinais')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Digite o nome do sinal...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
              onChanged: (val) => setState(() => _query = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text('Nenhum sinal encontrado.'))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) => SignCard(sign: searchResults[index]),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
