import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hands Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        primaryColor: const Color(0xFF0F172A), 
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

// --- GERENCIADOR DE ESTADO GLOBAL (GAMIFICAÇÃO & PROGRESSÃO) ---
class AppState {
  static int xp = 450;
  static int ofensiva = 5;
  static int nivelAtualMaximoDesbloqueado = 1;
  static List<String> medalhas = ['Pioneira 🏅', 'Primeiro Passo 🚀'];
  
  static List<Map<String, String>> listaFavoritos = [
    {'nome': 'Sinal de Obrigado 👋', 'desc': 'Mão aberta tocando a testa e saindo para a frente.'}
  ];
}

// --- 1. TELA DE LOGIN ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _fazerLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha as credenciais.'), backgroundColor: Colors.red),
      );
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                    child: const Icon(Icons.blur_on_rounded, size: 70, color: Color(0xFF38BDF8)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'HANDS CONNECT',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 3.0),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sistemas de Aprendizado Neural em Libras',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8), letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'ID ou E-mail',
                      labelStyle: const TextStyle(color: Color(0xFF64748B)),
                      filled: true,
                      fillColor: const Color(0xFF1E293B),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF38BDF8), width: 1.5)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Chave de Acesso',
                      labelStyle: const TextStyle(color: Color(0xFF64748B)),
                      filled: true,
                      fillColor: const Color(0xFF1E293B),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF38BDF8), width: 1.5)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38BDF8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      onPressed: _fazerLogin,
                      child: const Text('INICIAR SESSÃO', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 2. TELA PRINCIPAL (HOME) ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double progressoNivel = (AppState.nivelAtualMaximoDesbloqueado / 5);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workspace', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
            SizedBox(height: 2),
            Text('Olá, Raquel 👋', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF0F172A), size: 22),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          ),
        ],
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TradutorScreen())),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.filter_center_focus_rounded, color: Color(0xFF38BDF8), size: 28),
                            Text('Computer Vision\nTradutor Câmera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AprenderScreen())),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.model_training_rounded, color: Color(0xFF0F172A), size: 28),
                            Text('Laboratório de\nExercícios Práticos', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text('Painel de Métricas Analíticas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: CircularProgressIndicator(
                          value: progressoNivel,
                          strokeWidth: 6,
                          backgroundColor: const Color(0xFFF1F5F9),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Trilha de Aprendizado: Nível ${AppState.nivelAtualMaximoDesbloqueado}/5', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                            const SizedBox(height: 4),
                            Text('Medalhas: ${AppState.medalhas.join("  ")}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFF1F5F9), height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusColumn('${AppState.xp}', 'XP Total'),
                      Container(height: 25, width: 1, color: const Color(0xFFE2E8F0)),
                      _buildStatusColumn('${AppState.ofensiva} dias', 'Ofensiva 🔥'),
                      Container(height: 25, width: 1, color: const Color(0xFFE2E8F0)),
                      _buildStatusColumn('${AppState.nivelAtualMaximoDesbloqueado * 4}', 'Fases Finais'),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text('Navegação de Subsistemas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _buildGridItem(context, Icons.analytics_rounded, 'Desafio Quiz Trilha', const QuizFasesScreen(), true),
                _buildGridItem(context, Icons.terminal_rounded, 'Professor Virtual IA', const ChatScreen(), false),
                _buildGridItem(context, Icons.video_library_rounded, 'Aulas Gravadas', const VideoAulasScreen(), false),
                _buildGridItem(context, Icons.favorite_border_rounded, 'Meus Favoritos', const FavoritosScreen(), false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusColumn(String numero, String legenda) {
    return Column(
      children: [
        Text(numero, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
        const SizedBox(height: 2),
        Text(legenda, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
      ],
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label, Widget target, bool destacar) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => target)).then((value) => setState(() {}));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: destacar ? const Color(0xFFDCFCE7) : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: destacar ? const Color(0xFF4CAF50) : const Color(0xFFE2E8F0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: destacar ? const Color(0xFF166534) : const Color(0xFF0F172A), size: 26),
            const SizedBox(height: 14),
            Text(label, style: TextStyle(fontWeight: FontWeight.w900, color: destacar ? const Color(0xFF166534) : const Color(0xFF334155), fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// --- 3. LABORATÓRIO DE EXERCÍCIOS PRÁTICOS E INTUITIVOS ---
class AprenderScreen extends StatefulWidget {
  const AprenderScreen({super.key});
  @override
  State<AprenderScreen> createState() => _AprenderScreenState();
}

class _AprenderScreenState extends State<AprenderScreen> {
  final List<Map<String, String>> exerciciosMorfologia = [
    {'nome': 'Alfabeto Manual: Letra A 👍', 'desc': 'Feche a mão ativa deixando o polegar posicionado de forma lateral e esticado ao lado do indicador.', 'metrica': 'Alvo: Configuração de Mão Estática', 'tipo': 'Nível 1: Iniciante'},
    {'nome': 'Cumprimentos: Sinal de Oi 👋', 'desc': 'Faça a letra O e em seguida levante o dedo mínimo formando a letra I, movendo levemente para o lado.', 'metrica': 'Alvo: Transição Fluida Orbital', 'tipo': 'Nível 1: Iniciante'},
    {'nome': 'Sinal de Gato 🐱', 'desc': 'Puxe os dedos indicador e polegar em formato de pinça partindo das bochechas simulando os bigodes.', 'metrica': 'Alvo: Ponto de Articulação Facial', 'tipo': 'Nível 2: Básico'},
  ];

  final List<Map<String, String>> exerciciosLinguistica = [
    {'nome': 'Sinal de Expressão de Dúvida 🤨', 'desc': 'Sinale "Por que" franzindo levemente as sobrancelhas e inclinando a cabeça levemente para trás.', 'metrica': 'Alvo: Expressão Facial Gramatical', 'tipo': 'Nível 3: Intermediário'},
    {'nome': 'Sinal de Chocolate 🍫', 'desc': 'Mão em formato de gancho raspando suavemente na base inferior do queixo em movimentos cíclicos.', 'metrica': 'Alvo: Movimento Cíclico de Atrito', 'tipo': 'Nível 2: Básico'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0F172A),
          elevation: 0,
          title: const Text('Laboratório Prático de Libras', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          bottom: const TabBar(
            labelColor: Color(0xFF0F172A),
            unselectedLabelColor: Color(0xFF94A3B8),
            indicatorColor: Color(0xFF0F172A),
            tabs: [Tab(text: 'Eixo Fundamentos'), Tab(text: 'Eixo Avançado')],
          ),
        ),
        body: TabBarView(
          children: [
            _buildListaLabs(exerciciosMorfologia),
            _buildListaLabs(exerciciosLinguistica),
          ],
        ),
      ),
    );
  }

  Widget _buildListaLabs(List<Map<String, String>> itens) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: itens.length,
      itemBuilder: (context, i) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itens[i]['tipo']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8))),
              const SizedBox(height: 6),
              Text(itens[i]['nome']!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF0F172A))),
              const SizedBox(height: 8),
              Text(itens[i]['desc']!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.4)),
              const Divider(height: 20, color: Color(0xFFF1F5F9)),
              Text(itens[i]['metrica']!, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}

// --- 4. CHAT INTELIGENTE DO PROFESSOR VIRTUAL DE LIBRAS ---
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [
    {"sender": "ia", "text": "Olá Raquel! Sou o seu Professor Virtual 24h. Posso te ensinar sinais passo a passo, explicar expressões faciais, corrigir erros ou criar exercícios personalizados. O que quer treinar agora?"}
  ];
  final _controller = TextEditingController();

  void _processarRespostaIA(String textoUsuario) {
    String resposta = "Interessante! Para executar esse parâmetro em Libras, lembre-se de sincronizar a configuração da mão com a expressão facial correta. Quer que eu detalhe o passo a passo?";
    String txtLower = textoUsuario.toLowerCase();

    if (txtLower.contains("oi") || txtLower.contains("olá")) {
      resposta = "Olá! Vamos treinar hoje? Posso te passar o passo a passo do alfabeto manual ou criar um exercício adaptado para você.";
    } else if (txtLower.contains("gato") || txtLower.contains("sinal")) {
      resposta = "Explicando o sinal de GATO 🐱 passo a passo:\n1. Configure a mão em pinça (dedos polegar e indicador).\n2. Encoste na bochecha (ponto de articulação).\n3. Puxe para fora simulando os bigodes. Tente fazer aí na câmera!";
    } else if (txtLower.contains("expressão") || txtLower.contains("facial")) {
      resposta = "Excelente ponto! Em Libras, as expressões faciais e corporais determinam a entonação da frase (se é pergunta, exclamação ou sentimento). Por exemplo, para indicar dúvida, franza as sobrancelhas levemente.";
    } else if (txtLower.contains("exercício") || txtLower.contains("treino")) {
      resposta = "Criando Exercício Personalizado de Nível Iniciante adaptado para você:\n👉 Execute a datilologia da palavra 'AMOR' letra por letra. Precisa de ajuda com alguma letra?";
    } else if (txtLower.contains("erro") || txtLower.contains("corrigir")) {
      resposta = "A IA detectou uma leve inclinação errada no seu pulso durante o último treino com câmera. Lembre-se de manter o eixo neutro em 90 graus para não distorcer o sinal de BANANA.";
    }

    setState(() {
      _messages.add({"sender": "ia", "text": resposta});
    });
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    String userText = _controller.text;
    setState(() {
      _messages.add({"sender": "user", "text": userText});
    });
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _processarRespostaIA(userText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), title: const Text('Professor Virtual Libras IA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)), elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final isUser = _messages[i]["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF0F172A) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: isUser ? null : Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(_messages[i]["text"]!, style: TextStyle(color: isUser ? Colors.white : const Color(0xFF334155), fontSize: 14, fontWeight: FontWeight.w500, height: 1.3)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Tire dúvidas, peça um sinal ou exercício...',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF0F172A))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(icon: const Icon(Icons.send_rounded, color: Color(0xFF0F172A)), onPressed: _sendMessage),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// --- 5. SELEÇÃO DE FASES DO QUIZ (ESTILO DUOLINGO PROGRESSIVO) ---
class QuizFasesScreen extends StatefulWidget {
  const QuizFasesScreen({super.key});
  @override
  State<QuizFasesScreen> createState() => _QuizFasesScreenState();
}

class _QuizFasesScreenState extends State<QuizFasesScreen> {
  final List<Map<String, dynamic>> niveisConfig = [
    {'id': 1, 'titulo': 'Nível 1: Iniciante', 'sub': 'Alfabeto, Números e Cumprimentos', 'icon': Icons.abc_rounded},
    {'id': 2, 'titulo': 'Nível 2: Básico', 'sub': 'Família, Cores e Rotinas cotidianas', 'icon': Icons.home_rounded},
    {'id': 3, 'titulo': 'Nível 3: Intermediário', 'sub': 'Construção de Frases e Verbos', 'icon': Icons.forum_rounded},
    {'id': 4, 'titulo': 'Nível 4: Avançado', 'sub': 'Narrativas Longas e Contexto Profissional', 'icon': Icons.work_rounded},
    {'id': 5, 'titulo': 'Nível 5: Fluência', 'sub': 'Conversação em Velocidade Real e Complexa', 'icon': Icons.bolt_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), elevation: 0, title: const Text('Trilha de Níveis Hands Connect', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16))),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: niveisConfig.length,
        itemBuilder: (context, index) {
          var nv = niveisConfig[index];
          bool bloqueado = nv['id'] > AppState.nivelAtualMaximoDesbloqueado;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: bloqueado ? const Color(0xFFF1F5F9) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: bloqueado ? const Color(0xFFE2E8F0) : const Color(0xFF58CC02), width: 2),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(20),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: bloqueado ? const Color(0xFFCBD5E1) : const Color(0xFF58CC02), shape: BoxShape.circle),
                child: Icon(bloqueado ? Icons.lock_rounded : nv['icon'] as IconData, color: Colors.white, size: 24),
              ),
              title: Text(nv['titulo'] as String, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: bloqueado ? const Color(0xFF94A3B8) : const Color(0xFF0F172A))),
              subtitle: Text(nv['sub'] as String, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.3)),
              trailing: bloqueado 
                ? null 
                : const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF58CC02), size: 18),
              onTap: bloqueado ? () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('🔒 Complete o nível anterior para desbloquear esta fase!'), backgroundColor: Colors.black87));
              } : () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => QuizJogoEngine(nivelSelecionado: nv['id'] as int))).then((value) {
                  setState(() {});
                });
              },
            ),
          );
        },
      ),
    );
  }
}

// --- 6. MOTOR DE JOGO DO QUIZ (TIPOS DIVERSIFICADOS DE QUESTÕES) ---
class QuizJogoEngine extends StatefulWidget {
  final int nivelSelecionado;
  const QuizJogoEngine({super.key, required this.nivelSelecionado});
  @override
  State<QuizJogoEngine> createState() => _QuizJogoEngineState();
}

class _QuizJogoEngineState extends State<QuizJogoEngine> {
  int _indexQuestao = 0;
  bool _finalizado = false;
  int _opcaoSelecionada = -1;
  bool _feedbackLiberado = false;

  final Map<int, List<Map<String, dynamic>>> bancoQuestoesPorNivel = {
    1: [
      {
        'tipo': 'IDENTIFICAÇÃO DE SINAL',
        'q': 'Qual o significado do sinal executado com a configuração em formato da letra L batendo levemente no queixo?',
        'a': [{'t': 'Sinal de CUMPRIMENTO: Boa Tarde', 'c': false}, {'t': 'Sinal de NÚMERO: Quantidade de anos/idade', 'c': true}]
      },
      {
        'tipo': 'EXERCÍCIO COM CÂMERA EMULADA',
        'q': 'Ative sua câmera e execute o alfabeto manual correspondente à letra inicial do seu nome.',
        'a': [{'t': 'Posicionar a mão em formato correto de pinça', 'c': true}, {'t': 'Manter o braço totalmente fechado no tronco', 'c': false}]
      }
    ],
    2: [
      {
        'tipo': 'COMPLETAR FRASES',
        'q': 'Complete o contexto da frase: "MINHA MÃE TRABALHAR LOJA ____" (Sinal de cor de uniforme)',
        'a': [{'t': 'Sinal da cor AZUL (Mão em formato de A girando para Z)', 'c': true}, {'t': 'Sinal da cor VERDE (Mão raspando o dorso)', 'c': false}]
      }
    ],
    3: [
      {
        'tipo': 'INTERPRETAÇÃO DE VÍDEOS',
        'q': 'Análise da estrutura sintática: O verbo ir foi conjugado no espaço neutro lateral direcionado.',
        'a': [{'t': 'Sim, indica ponto de destino contextual', 'c': true}, {'t': 'Não, indica apenas erro posicional', 'c': false}]
      }
    ],
    4: [
      {
        'tipo': 'NARRATIVAS E CONTEXTO',
        'q': 'Em uma interpretação jurídica profissional, o sinal de LEI deve obrigatoriamente tocar qual superfície?',
        'a': [{'t': 'A palma da mão passiva aberta verticalmente', 'c': true}, {'t': 'O espaço neutro frontal inferior', 'c': false}]
      }
    ],
    5: [
      {
        'tipo': 'CONVERSAÇÃO NATURAL REAL',
        'q': 'Em velocidade de conversação natural avançada, a omissão de pronomes repetitivos é permitida?',
        'a': [{'t': 'Sim, a marcação ocular substitui pronomes', 'c': true}, {'t': 'Não, quebra totalmente a gramática oficial', 'c': false}]
      }
    ]
  };

  void _validarAlternativa(int idx, bool correta) {
    if (_feedbackLiberado) return;
    setState(() {
      _opcaoSelecionada = idx;
      _feedbackLiberado = true;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      var listaFase = bancoQuestoesPorNivel[widget.nivelSelecionado]!;
      setState(() {
        if (_indexQuestao < listaFase.length - 1) {
          _indexQuestao++;
          _opcaoSelecionada = -1;
          _feedbackLiberado = false;
        } else {
          _finalizado = true;
          AppState.xp += 50;
          if (widget.nivelSelecionado == AppState.nivelAtualMaximoDesbloqueado && AppState.nivelAtualMaximoDesbloqueado < 5) {
            AppState.nivelAtualMaximoDesbloqueado++;
            if (AppState.nivelAtualMaximoDesbloqueado == 3) {
              AppState.medalhas.add('Intermediária 🏆');
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var listaFase = bancoQuestoesPorNivel[widget.nivelSelecionado] ?? [];
    if (listaFase.isEmpty) return const Scaffold(body: Center(child: Text("Fase Em Desenvolvimento")));
    
    double progresso = (_indexQuestao + 1) / listaFase.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        title: Text('Desafio Nível ${widget.nivelSelecionado}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: _finalizado
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(padding: const EdgeInsets.all(24), decoration: const BoxDecoration(color: Color(0xFFFEF08A), shape: BoxShape.circle), child: const Icon(Icons.emoji_events_rounded, size: 70, color: Color(0xFFEAB308))),
                      const SizedBox(height: 24),
                      const Text('Fase Concluída! 🎉', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      const SizedBox(height: 8),
                      const Text('Você ganhou +50 XP e desbloqueou a próxima trilha!', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF58CC02), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4, shadowColor: const Color(0xFF46A302)),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('VOLTAR PARA A TRILHA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: MediaQuery.of(context).size.width * 0.7 * progresso,
                                  decoration: BoxDecoration(color: const Color(0xFF58CC02), borderRadius: BorderRadius.circular(20)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text('${_indexQuestao + 1}/${listaFase.length}', style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF94A3B8))),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(12)),
                      child: Text(listaFase[_indexQuestao]['tipo'] as String, style: const TextStyle(color: Color(0xFF38BDF8), fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.0)),
                    ),
                    const SizedBox(height: 20),
                    Text(listaFase[_indexQuestao]['q'] as String, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.3)),
                    const SizedBox(height: 32),
                    ...List.generate((listaFase[_indexQuestao]['a'] as List).length, (i) {
                      var op = (listaFase[_indexQuestao]['a'] as List)[i];
                      Color backColor = Colors.white;
                      Color borderColor = const Color(0xFFE2E8F0);
                      Color fontColor = const Color(0xFF334155);

                      if (_feedbackLiberado) {
                        if (op['c'] == true) {
                          backColor = const Color(0xFFE8F5E9);
                          borderColor = const Color(0xFF4CAF50);
                          fontColor = const Color(0xFF1B5E20);
                        } else if (_opcaoSelecionada == i) {
                          backColor = const Color(0xFFFFEBEE);
                          borderColor = const Color(0xFFF44336);
                          fontColor = const Color(0xFFB71C1C);
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () => _validarAlternativa(i, op['c'] as bool),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: backColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border(
                                top: BorderSide(color: borderColor, width: 2),
                                left: BorderSide(color: borderColor, width: 2),
                                right: BorderSide(color: borderColor, width: 2),
                                bottom: BorderSide(color: borderColor, width: 5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(radius: 12, backgroundColor: const Color(0xFFF1F5F9), child: Text('${i+1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                                const SizedBox(width: 16),
                                Expanded(child: Text(op['t'] as String, style: TextStyle(color: fontColor, fontWeight: FontWeight.w800, fontSize: 14))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
        ),
      ),
    );
  }
}

// --- 7. HUB DE VÍDEO AULAS INTERATIVAS (RESTADO DO ZERO!) ---
class VideoAulasScreen extends StatelessWidget {
  const VideoAulasScreen({super.key});

  void _abrirPlayerVideo(BuildContext context, String titulo, String nivel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Color(0xFF0F172A), 
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 24),
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.play_circle_filled_rounded, color: Color(0xFF38BDF8), size: 64),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('02:40 / 15:00', style: TextStyle(color: Colors.white60, fontSize: 11)),
                          Icon(Icons.fullscreen_rounded, color: Colors.white, size: 18),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(nivel.toUpperCase(), style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              const SizedBox(height: 8),
              Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text(
                'Esta videoaula compreende a análise de parâmetros estruturais e a correção de gestos e micro-expressões faciais obrigatórias para validação gramatical.',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13, height: 1.4),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0F172A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.pause_rounded),
                label: const Text('MINIMIZAR PLAYER', style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final iniciante = [
      {'titulo': 'Módulo Core: Alfabeto e Primeiros Passos', 'duracao': '10 min'},
      {'titulo': 'Gramática I: Estrutura do Espaço Neutro', 'duracao': '08 min'},
    ];
    final intermediario = [
      {'titulo': 'Módulo Avançado de Sinais de Alimentos', 'duracao': '14 min'},
      {'titulo': 'Gesticulação Fluida de Reino Animal', 'duracao': '18 min'},
    ];
    final avancado = [
      {'titulo': 'Uso Prático de Classificadores Complexos', 'duracao': '22 min'},
      {'titulo': 'Análise de Contextualização Dialética', 'duracao': '25 min'},
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0F172A),
          elevation: 0,
          title: const Text('Streaming Hub de Aulas', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          bottom: const TabBar(
            labelColor: Color(0xFF0F172A),
            unselectedLabelColor: Color(0xFF94A3B8),
            indicatorColor: Color(0xFF0F172A),
            tabs: [
              Tab(text: 'Iniciante'),
              Tab(text: 'Médio'),
              Tab(text: 'Avançado'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAbasVideos(context, iniciante, 'Iniciante'),
            _buildAbasVideos(context, intermediario, 'Intermediário'),
            _buildAbasVideos(context, avancado, 'Avançado'),
          ],
        ),
      ),
    );
  }

  Widget _buildAbasVideos(BuildContext context, List<Map<String, String>> videos, String nivel) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: videos.length,
      itemBuilder: (context, i) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.play_arrow_rounded, color: Color(0xFF0F172A), size: 24),
            ),
            title: Text(videos[i]['titulo']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A), fontSize: 14)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Duração: ${videos[i]['duracao']} • Clique para assistir', style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
            ),
            onTap: () => _abrirPlayerVideo(context, videos[i]['titulo']!, nivel),
          ),
        );
      },
    );
  }
}

// --- 8. DEMAIS TELAS DO ECOSSISTEMA ---
class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), elevation: 0, title: const Text('Workspace de Favoritos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: AppState.listaFavoritos.length,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: ListTile(
              title: Text(AppState.listaFavoritos[i]['nome']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(AppState.listaFavoritos[i]['desc']!),
            ),
          );
        },
      ),
    );
  }
}

class TradutorScreen extends StatelessWidget {
  const TradutorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), title: const Text('Computer Vision Live')),
      body: const Center(child: Text('Aguardando ativação do hardware óptico...', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF94A3B8)))),
    );
  }
}
