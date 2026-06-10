import 'dart:convert';
import 'package:http/http.dart' as http;

class AIChatService {
  final String? apiKey;
  AIChatService({this.apiKey});

  Future<String> sendMessage(String message) async {
    if (apiKey != null && apiKey!.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('https://api.anthropic.com/v1/messages'),
          headers: {
            'content-type': 'application/json',
            'x-api-key': apiKey!,
            'anthropic-version': '2023-06-01'
          },
          body: jsonEncode({
            'model': 'claude-3-haiku-20240307',
            'max_tokens': 1024,
            'messages': [{'role': 'user', 'content': message}]
          }),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['content'][0]['text'];
        }
      } catch (_) {}
    }

    await Future.delayed(const Duration(milliseconds: 800));
    final msg = message.toLowerCase();
    if (msg.contains('olá') || msg.contains('oi')) {
      return 'Olá! Sou o assistente do Hands Connect. Como posso te ajudar na sua jornada de aprendizado de Libras hoje?🤟';
    } else if (msg.contains('gramática') || msg.contains('estrutura')) {
      return 'Na Libras, a estrutura gramatical padrão mais comum difere do Português, utilizando frequentemente a ordem Sujeito-Objeto-Verbo (SOV) ou Tempo-Sujeito-Objeto-Verbo!';
    } else if (msg.contains('expressão') || msg.contains('facial')) {
      return 'As expressões faciais e corporais são fundamentais na Libras. Elas determinam entonações, intensidade e até diferenciam afirmações de perguntas!';
    }
    return 'Excelente pergunta! Na comunidade Libras, praticar a repetição visual diária é o segredo para a fluência de sinais. Deseja revisar algum sinal específico?';
  }
}
