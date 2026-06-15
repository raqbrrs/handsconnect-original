<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HandsConnectApp());
}

class HandsConnectApp extends StatelessWidget {
  const HandsConnectApp({super.key});
=======
﻿import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
>>>>>>> 565e70d (projeto)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hands Connect',
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
=======
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        primaryColor: const Color(0xFF0F172A), 
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

// --- GERENCIADOR DE ESTADO SIMPLES ---
class FavoritosManager {
  static final List<Map<String, String>> listaFavoritos = [
    {'nome': 'Sinal de Obrigado 👋', 'desc': 'Mão aberta tocando a testa e saindo para a frente.'}
  ];
}

// --- 1. TELA DE LOGIN (MINIMALISTA & TECH) ---
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
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(scale: value, child: child),
                      );
                    },
                    child: Container(
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.transparent, // CORRIGIDO PARA O TIPO CORRETO
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.blur_on_rounded, size: 70, color: Color(0xFF38BDF8)),
                    ),
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

// --- 2. TELA PRINCIPAL (HOME ECOSYSTEM) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        // CORRIGIDO: Linha inferior minimalista implementada via shape
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
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 8))],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.filter_center_focus_rounded, color: Color(0xFF38BDF8), size: 32),
                            Text('Computer Vision\nTradutor Câmera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, height: 1.3)),
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
                      height: 150,
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
                            Icon(Icons.model_training_rounded, color: Color(0xFF0F172A), size: 32),
                            Text('Laboratório de\nExercícios Práticos', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 15, height: 1.3)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Análise de Desempenho', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 0.5)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: 0.65,
                      strokeWidth: 5,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0F172A)),
                    ),
                  ),
                  const SizedBox(width: 24),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('65% de Sincronia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                        SizedBox(height: 4),
                        Text('Módulo atual: Configuração Manual III', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Grid de Módulos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 0.5)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.25,
              children: [
                _buildGridItem(context, Icons.favorite_border_rounded, 'Coleção de Favoritos', const FavoritosScreen()),
                _buildGridItem(context, Icons.terminal_rounded, 'Assistente Core IA', const ChatScreen()),
                _buildGridItem(context, Icons.video_library_rounded, 'Streaming de Aulas', const VideoAulasScreen()),
                _buildGridItem(context, Icons.analytics_rounded, 'Validador de Quiz', const QuizScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label, Widget target) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => target)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0F172A), size: 26),
            const SizedBox(height: 14),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155), fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// --- 3. EXERCÍCIOS OFICIAIS DE LIBRAS (AULAS PRÁTICAS AVANÇADAS) ---
class AprenderScreen extends StatefulWidget {
  const AprenderScreen({super.key});
  @override
  State<AprenderScreen> createState() => _AprenderScreenState();
}

class _AprenderScreenState extends State<AprenderScreen> {
  final List<Map<String, String>> exerciciosMorfologia = [
    {
      'nome': 'Exercício 1: Configuração Manual (CM 4) 🐾',
      'desc': 'Posicione a mão em formato de garra aberta. Mova verticalmente simulando o contorno facial.',
      'metrica': 'Alvo de Articulação: Espaço Neutro Frontal',
      'tipo': 'Animal: Leão'
    },
    {
      'nome': 'Exercício 2: Ponto de Articulação Bochecha 🐱',
      'desc': 'Utilize os dedos indicador e polegar em pinça partindo da região zigomática para fora.',
      'metrica': 'Alvo de Articulação: Toque Bochecha Lateral',
      'tipo': 'Animal: Gato'
    }
  ];

  final List<Map<String, String>> exerciciosLinguistica = [
    {
      'nome': 'Exercício 3: Movimento Descendente Linear 🍌',
      'desc': 'Mantenha a mão passiva estendida e efetuando a simulação de extração de camadas com a mão ativa.',
      'metrica': 'Direcionamento: Eixo Vertical Inferior',
      'tipo': 'Fruta: Banana'
    },
    {
      'nome': 'Exercício 4: Rotação Orbital de Pulso 🍎',
      'desc': 'Configuração de mão em "C" fechado sobre o eixo lateral da face, efetuando rotação de 45 graus.',
      'metrica': 'Direcionamento: Rotação Interna Angular',
      'tipo': 'Fruta: Maçã'
    }
  ];

  void _alternarFavorito(Map<String, String> item) {
    setState(() {
      bool existe = FavoritosManager.listaFavoritos.any((element) => element['nome'] == item['nome']);
      if (existe) {
        FavoritosManager.listaFavoritos.removeWhere((element) => element['nome'] == item['nome']);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exercício removido dos logs!')));
      } else {
        FavoritosManager.listaFavoritos.add(item);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exercício favoritado no Workspace! 🎉'), backgroundColor: Colors.black87));
      }
    });
  }

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
          title: const Text('Módulos de Exercícios Oficiais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
          bottom: const TabBar(
            labelColor: Color(0xFF0F172A),
            unselectedLabelColor: Color(0xFF94A3B8),
            indicatorColor: Color(0xFF0F172A),
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Eixo Animais'),
              Tab(text: 'Eixo Alimentos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLaboratorioLabs(exerciciosMorfologia),
            _buildLaboratorioLabs(exerciciosLinguistica),
          ],
        ),
      ),
    );
  }

  Widget _buildLaboratorioLabs(List<Map<String, String>> itens) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: itens.length,
      itemBuilder: (context, i) {
        bool isFav = FavoritosManager.listaFavoritos.any((element) => element['nome'] == itens[i]['nome']);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
                    child: Text(itens[i]['tipo']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                  ),
                  IconButton(
                    icon: Icon(isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: Colors.black87, size: 20),
                    onPressed: () => _alternarFavorito(itens[i]),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Text(itens[i]['nome']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A))),
              const SizedBox(height: 8),
              Text(itens[i]['desc']!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.4)),
              const Divider(height: 24, color: Color(0xFFF1F5F9)),
              Row(
                children: [
                  const Icon(Icons.bolt, size: 14, color: Color(0xFF38BDF8)),
                  const SizedBox(width: 6),
                  Expanded(child: Text(itens[i]['metrica']!, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w500))),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// --- 4. STREAMING DE VÍDEO AULAS INTERATIVAS ---
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
      {'titulo': 'Módulo Core: Configurações de Mão Unilaterais', 'duracao': '10 min'},
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
          title: const Text('Streaming Hub de Aulas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
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

// --- 5. TELA DE FAVORITOS (CLEAN MINIMALIST) ---
class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});
  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  Widget build(BuildContext context) {
    var favs = FavoritosManager.listaFavoritos;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text('Workspace de Favoritos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      body: favs.isEmpty
          ? const Center(child: Text('Nenhum log favoritado.', style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favs.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: const Icon(Icons.bookmark_rounded, color: Color(0xFF0F172A)),
                    title: Text(favs[i]['nome']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A))),
                    subtitle: Text(favs[i]['desc'] ?? '', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    trailing: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8), size: 18),
                      onPressed: () {
                        setState(() {
                          favs.removeAt(i);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// --- 6. TRADUTOR CÂMERA ---
class TradutorScreen extends StatefulWidget {
  const TradutorScreen({super.key});
  @override
  State<TradutorScreen> createState() => _TradutorScreenState();
}

class _TradutorScreenState extends State<TradutorScreen> {
  String _res = "Aguardando captura de movimento...";
  bool _loading = false;

  void _traduzir() {
    setState(() { _loading = true; });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
        _res = "Análise Concluída: 'BANANA' 🍌";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), title: const Text('Computer Vision Live', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), elevation: 0, shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1))),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(32)),
              child: Center(
                child: _loading 
                  ? const CircularProgressIndicator(color: Color(0xFF38BDF8))
                  : const Icon(Icons.videocam_rounded, size: 48, color: Colors.white24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: Column(
              children: [
                Text(_res, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: _traduzir,
                    child: const Text('PROCESSAR GESTO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// --- 7. CHAT CORE IA (MINIMAL INTERFACE) ---
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [
    {"sender": "ia", "text": "Olá Raquel. Pronta para calibrar seus exercícios de articulação manual?"}
  ];
  final _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": _controller.text});
    });
    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({"sender": "ia", "text": "Entendido. Para esse sinal, certifique-se de manter o pulso no ângulo neutro de 90°."});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), title: const Text('Assistente Neural Core', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), elevation: 0, shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1))),
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
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF0F172A) : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: isUser ? null : Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(_messages[i]["text"]!, style: TextStyle(color: isUser ? Colors.white : const Color(0xFF334155), fontSize: 14, fontWeight: FontWeight.w500)),
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
                      hintText: 'Pergunte sobre parâmetros...',
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

// --- 8. VALIDADOR DE QUIZ (MINIMALISTA TECH COM VETORES SIMULADOS) ---
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _pontos = 0;
  bool _fim = false;
  int _opcaoSelecionada = -1;
  bool _mostrouFeedback = false;

  final _perguntas = [
    {
      'q': 'Qual a movimentação padrão no sinal de BANANA 🍌?',
      'imgLabel': 'VETOR: Direcional Descendente Unilateral',
      'icon': Icons.layers_rounded,
      'a': [
        {'t': 'Simulação de extração de camadas verticais', 'c': true},
        {'t': 'Giro orbital contínuo de pulso', 'c': false},
      ]
    },
    {
      'q': 'O sinal gramatical de GATO 🐱 exige qual ponto de articulação?',
      'imgLabel': 'VETOR: Ponto de Contato Zigomático',
      'icon': Icons.face_retouching_natural_rounded,
      'a': [
        {'t': 'Região frontal do espaço neutro', 'c': false},
        {'t': 'Puxamento lateral próximo às bochechas', 'c': true},
      ]
    }
  ];

  void _validarResposta(int idxOpcao, bool correta) {
    if (_mostrouFeedback) return;
    setState(() {
      _opcaoSelecionada = idxOpcao;
      _mostrouFeedback = true;
      if (correta) _pontos += 10;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        if (_index < _perguntas.length - 1) {
          _index++;
          _opcaoSelecionada = -1;
          _mostrouFeedback = false;
        } else {
          _fim = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F172A), title: const Text('Validação de Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), elevation: 0, shape: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _fim
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 70, color: Color(0xFF0F172A)),
                    const SizedBox(height: 16),
                    const Text('Validação Concluída', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    const SizedBox(height: 6),
                    Text('Métrica final: $_pontos pts', style: const TextStyle(fontSize: 16, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('ETAPA ${_index + 1} DE ${_perguntas.length}', style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.0), textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  
                  // BOX VETORIAL MINIMALISTA TECH
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_perguntas[_index]['icon'] as IconData, size: 40, color: const Color(0xFF38BDF8)),
                        const SizedBox(height: 12),
                        Text(_perguntas[_index]['imgLabel'] as String, style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  Text(_perguntas[_index]['q'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)), textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  
                  ...List.generate((_perguntas[_index]['a'] as List).length, (i) {
                    var op = (_perguntas[_index]['a'] as List)[i];
                    Color btnColor = Colors.white;
                    Color txtColor = const Color(0xFF0F172A);

                    if (_mostrouFeedback) {
                      if (op['c'] == true) {
                        btnColor = const Color(0xFFDCFCE7); 
                        txtColor = const Color(0xFF15803D);
                      } else if (_opcaoSelecionada == i) {
                        btnColor = const Color(0xFFFEE2E2); 
                        txtColor = const Color(0xFFB91C1C);
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: btnColor,
                          side: BorderSide(color: _mostrouFeedback && op['c'] == true ? const Color(0xFF22C55E) : const Color(0xFFE2E8F0), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          elevation: 0,
                        ),
                        onPressed: () => _validarResposta(i, op['c'] as bool),
                        child: Text(op['t'] as String, style: TextStyle(color: txtColor, fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    );
                  }),
                ],
              ),
      ),
>>>>>>> 565e70d (projeto)
    );
  }
}
