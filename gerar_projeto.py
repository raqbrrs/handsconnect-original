import os

# Estrutura completa do projeto Hands Connect
project_structure = {
    "pubspec.yaml": """name: hands_connect
description: "Hands Connect - Libras Learning Application"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  sqflite: ^2.3.0
  path: ^1.8.3
  crypto: ^3.0.3
  camera: ^0.10.5+5
  http: ^1.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
""",
    "lib/theme/app_theme.dart": """import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF3F51B5);
  static const Color primaryLight = Color(0xFFC5CAE9);
  static const Color secondary = Color(0xFF7C4DFF);
  static const Color background = Color(0xFFF5F6FA);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textLight = Color(0xFF95A5A6);
  static const Color surface = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(color: textDark, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      cardTheme: CardTheme(
        color: surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
""",
    "lib/models/sign_model.dart": """class SignModel {
  final int? id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;

  SignModel({
    this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory SignModel.fromMap(Map<String, dynamic> map) {
    return SignModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }
}
""",
    "lib/models/user_model.dart": """class UserModel {
  final int? id;
  final String username;
  final String email;
  final String passwordHash;

  UserModel({this.id, required this.username, required this.email, required this.passwordHash});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'email': email, 'password_hash': passwordHash};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      passwordHash: map['password_hash'],
    );
  }
}
""",
    "lib/models/chat_message.dart": """class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, required this.timestamp});
}
""",
    "lib/data/signs_data.dart": """import '../models/sign_model.dart';

final List<SignModel> mockSigns = [
  SignModel(name: 'Cachorro', category: 'Animais', imageUrl: '🐶', description: 'Configure a mão em "A" perto do peito ou simule estalar os dedos.'),
  SignModel(name: 'Gato', category: 'Animais', imageUrl: '🐱', description: 'Passe os dedos indicador e polegar ao lado do rosto, simulando os bigodes.'),
  SignModel(name: 'Leão', category: 'Animais', imageUrl: '🦁', description: 'Passe as mãos abertas sobre a cabeça imitando a juba.'),
  SignModel(name: 'Maçã', category: 'Frutas', imageUrl: '🍎', description: 'Gire os dedos em garra levemente na bochecha.'),
  SignModel(name: 'Banana', category: 'Frutas', imageUrl: '🍌', description: 'Simule o ato de descascar uma banana com o indicador da outra mão.'),
  SignModel(name: 'Azul', category: 'Cores', imageUrl: '🟦', description: 'Faça a letra A e transforme em Z desenhando no ar.'),
  SignModel(name: 'Verde', category: 'Cores', imageUrl: '🟩', description: 'Balança a mão configurada em V na frente do corpo.'),
  SignModel(name: 'Um (1)', category: 'Números', imageUrl: '1️⃣', description: 'Levante o dedo indicador verticalmente com a palma voltada para dentro.'),
];
""",
    "lib/data/videos_data.dart": """class VideoLesson {
  final String title;
  final String duration;
  final String level;
  final bool isLocked;

  VideoLesson({required this.title, required this.duration, required this.level, required this.isLocked});
}

final List<VideoLesson> mockVideos = [
  VideoLesson(title: 'Introdução ao Alfabeto em Libras', duration: '12 min', level: 'Iniciante', isLocked: false),
  VideoLesson(title: 'Cumprimentos e Saudações', duration: '08 min', level: 'Iniciante', isLocked: false),
  VideoLesson(title: 'Expressões Faciais Gramaticais', duration: '15 min', level: 'Intermediário', isLocked: true),
  VideoLesson(title: 'Estrutura Sintática na Prática', duration: '22 min', level: 'Avançado', isLocked: true),
];
""",
    "lib/data/database_helper.dart": """import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hands_connect.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        sign_name TEXT NOT NULL
      )
    ''');
  }
}
""",
    "lib/services/auth_service.dart": """import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../data/database_helper.dart';
import '../models/user_model.dart';

class AuthService {
  static final AuthService instance = AuthService._init();
  UserModel? _currentUser;

  AuthService._init();

  UserModel? get currentUser => _currentUser;

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<bool> register(String username, String email, String password) async {
    final db = await DatabaseHelper.instance.database;
    try {
      await db.insert('users', {
        'username': username,
        'email': email,
        'password_hash': _hashPassword(password)
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password_hash = ?',
      whereArgs: [email, _hashPassword(password)],
    );

    if (maps.isNotEmpty) {
      _currentUser = UserModel.fromMap(maps.first);
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
  }
}
""",
    "lib/services/ai_chat_service.dart": """import 'dart:convert';
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
""",
    "lib/widgets/custom_button.dart": """import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const CustomButton({super.key, required this.text, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: color != null ? ElevatedButton.styleFrom(backgroundColor: color) : null,
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
""",
    "lib/widgets/sign_card.dart": """import 'package:flutter/material.dart';
import '../models/sign_model.dart';
import '../theme/app_theme.dart';

class SignCard extends StatelessWidget {
  final SignModel sign;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const SignCard({
    super.key,
    required this.sign,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(sign.imageUrl, style: const TextStyle(fontSize: 24)),
        ),
        title: Text(sign.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        subtitle: Text(sign.category, style: const TextStyle(color: AppTheme.textLight)),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : AppTheme.textLight,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
""",
    "lib/main.dart": """import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HandsConnectApp());
}

class HandsConnectApp extends StatelessWidget {
  const HandsConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hands Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
""",
    "lib/screens/splash_screen.dart": """import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.back_hand, size: 80, color: AppTheme.primary),
            ),
            const SizedBox(height: 24),
            const Text(
              'Hands Connect',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 8),
            Text('Aprenda Libras em Qualquer Lugar', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
""",
    "lib/screens/login_screen.dart": """import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    final success = await AuthService.instance.login(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainNavigation()));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciais inválidas ou usuário não registrado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.back_hand, size: 70, color: AppTheme.primary),
                const SizedBox(height: 16),
                const Text('Bem-vindo de volta', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                const SizedBox(height: 32),
                TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder())),
                const SizedBox(height: 24),
                _isLoading 
                    ? const Center(child: CircularProgressIndicator()) 
                    : CustomButton(text: 'Entrar', onPressed: _handleLogin),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  child: const Text('Não tem uma conta? Cadastre-se'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
""",
    "lib/screens/register_screen.dart": """import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleRegister() async {
    if (_userController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos')));
      return;
    }
    setState(() => _isLoading = true);
    final success = await AuthService.instance.register(_userController.text, _emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso!')));
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao cadastrar. E-mail já existe.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Nome de Usuário', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder())),
            const SizedBox(height: 24),
            _isLoading ? const CircularProgressIndicator() : CustomButton(text: 'Cadastrar', onPressed: _handleRegister),
          ],
        ),
      ),
    );
  }
}
""",
    "lib/screens/main_navigation.dart": """import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'community_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CommunityScreen(),
  ];

  void goToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: goToTab,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textLight,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidade'),
        ],
      ),
    );
  }
}
""",
    "lib/screens/home_screen.dart": """import 'package:flutter/material.dart';
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
    final user = AuthService.instance.currentUser;
    final username = user?.username ?? 'Estudante';

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $username! 👋'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              AuthService.instance.logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TranslateScreen())),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.secondary]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white, size: 36),
                          SizedBox(height: 8),
                          Text('Tradutor Câmera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.primaryLight),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book, color: AppTheme.primary, size: 36),
                          SizedBox(height: 8),
                          Text('Aulas Práticas', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold, fontSize: 16))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(
                            value: 0.65,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.secondary),
                          ),
                        ),
                        const Text('65%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seu Progresso Atual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('40 aulas concluídas de 62', style: TextStyle(color: AppTheme.textLight)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Acesso Rápido', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildShortcutItem(context, Icons.favorite, 'Favoritos', const FavoritesScreen()),
                _buildShortcutItem(context, Icons.chat, 'Chat IA', const ChatScreen()),
                _buildShortcutItem(context, Icons.video_library, 'Vídeos', const VideosScreen()),
                _buildShortcutItem(context, Icons.extension, 'Quiz Jogo', const QuizScreen()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutItem(BuildContext context, IconData icon, String label, Widget target) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => target)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundColor: AppTheme.primaryLight.withOpacity(0.4), child: Icon(icon, color: AppTheme.primary)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
""",
    "lib/screens/translate_screen.dart": """import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../theme/app_theme.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  CameraController? _controller;
  bool _isInitializing = true;
  String _detectedText = "Posicione sua mão na marcação...";

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;
      
      _controller = CameraController(cameras.first, ResolutionPreset.medium);
      await _controller!.initialize();
    } catch (_) {}
    if (mounted) setState(() => _isInitializing = false);
  }

  void _simulateDetection() async {
    setState(() => _detectedText = "Analisando gestos...");
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _detectedText = "Sinal Detectado: 'OBRIGADO' 🙏");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tradutor de Libras')),
      body: _isInitializing
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _controller != null && _controller!.value.isInitialized
                          ? CameraPreview(_controller!)
                          : Container(color: Colors.black, child: const Center(child: Text('Câmera Indisponível', style: TextStyle(color: Colors.white)))),
                      Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.secondary, width: 3),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(_detectedText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.transform),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Traduzir Sinal Atual'),
                        ),
                        onPressed: _simulateDetection,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
""",
    "lib/screens/learn_screen.dart": """import 'package:flutter/material.dart';
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
""",
    "lib/screens/category_screen.dart": """import 'package:flutter/material.dart';
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
""",
    "lib/screens/quiz_screen.dart": """import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _score = 0;
  bool _answered = false;
  String? _selectedOption;

  final String correctAnswer = 'Cachorro';
  final List<String> options = ['Gato', 'Cachorro', 'Leão', 'Passarinho'];

  void _checkAnswer(String option) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedOption = option;
      if (option == correctAnswer) _score += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Divertido')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(value: 0.25, backgroundColor: AppTheme.primaryLight),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pergunta 1 de 4', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Pontos: $_score', style: const TextStyle(color: AppTheme.secondary, fontWeight: FontWeight.bold)),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text('🐶\\n\\nQual é o significado deste sinal em Libras?', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),
            ...options.map((opt) {
              Color btnColor = Colors.white;
              if (_answered) {
                if (opt == correctAnswer) btnColor = Colors.green.shade200;
                if (opt == _selectedOption && opt != correctAnswer) btnColor = Colors.red.shade200;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: btnColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => _checkAnswer(opt),
                  child: Text(opt, style: const TextStyle(fontSize: 16, color: AppTheme.textDark)),
                ),
              );
            }),
            const SizedBox(height: 20),
            if (_answered) CustomButton(text: 'Próxima Pergunta', onPressed: () {
              setState(() {
                _answered = false;
                _selectedOption = null;
              });
            })
          ],
        ),
      ),
    );
  }
}
""",
    "lib/screens/favorites_screen.dart": """import 'package:flutter/material.dart';
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
""",
    "lib/screens/chat_screen.dart": """import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/ai_chat_service.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final _aiService = AIChatService();

  void _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true, timestamp: DateTime.now()));
    });

    final reply = await _aiService.sendMessage(text);
    setState(() {
      _messages.insert(0, ChatMessage(text: reply, isUser: false, timestamp: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assistente de IA')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: msg.isUser ? AppTheme.primary : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: msg.isUser ? const Radius.circular(0) : const Radius.circular(16),
                        topLeft: !msg.isUser ? const Radius.circular(0) : const Radius.circular(16),
                      ),
                    ),
                    child: Text(msg.text, style: TextStyle(color: msg.isUser ? Colors.white : AppTheme.textDark, fontSize: 15)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: TextField(controller: _textController, decoration: const InputDecoration(hintText: 'Pergunte sobre Libras...', border: InputBorder.none))),
                IconButton(icon: const Icon(Icons.send, color: AppTheme.primary), onPressed: _sendMessage)
              ],
            ),
          )
        ],
      ),
    );
  }
}
""",
    "lib/screens/videos_screen.dart": """import 'package:flutter/material.dart';
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
""",
    "lib/screens/community_screen.dart": """import 'package:flutter/material.dart';
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
""",
    "lib/screens/search_screen.dart": """import 'package:flutter/material.dart';
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
"""
}

# Criando os diretórios e gravando os arquivos no seu computador
for filepath, content in project_structure.items():
    dir_name = os.path.dirname(filepath)
    if dir_name and not os.path.exists(dir_name):
        os.makedirs(dir_name)
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)

print(">>> PROJETO CRIADO COM SUCESSO! <<<")