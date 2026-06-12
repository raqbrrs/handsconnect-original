import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget { 
  const LoginScreen({super.key}); 
  @override State<LoginScreen> createState() => _LoginScreenState(); 
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
        const SnackBar(content: Text('Acesso negado. Verifique os dados.'), backgroundColor: Colors.redAccent)
      ); 
    }
  }

  @override Widget build(BuildContext context) { 
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo Minimalista
                  Center(
                    child: Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.secondary]),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(Icons.blur_on, size: 40, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Hands Connect', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 1.0, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  const Text('Conectando mundos através da tecnologia.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppTheme.textLight)),
                  const SizedBox(height: 40),
                  
                  // Inputs
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail')),
                  const SizedBox(height: 14),
                  TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha')),
                  const SizedBox(height: 28),
                  
                  // Botão de Entrar
                  _isLoading 
                      ? const Center(child: CircularProgressIndicator(color: AppTheme.secondary)) 
                      : CustomButton(text: 'Acessar Plataforma', onPressed: _handleLogin),
                  
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen())), 
                    child: const Text('Criar nova conta tecnológica', style: TextStyle(color: AppTheme.textLight, fontSize: 13, decoration: TextDecoration.underline)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ); 
  }
}
