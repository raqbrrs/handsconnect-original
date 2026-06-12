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
        const SnackBar(content: Text('Verifique seu e-mail e senha.'), backgroundColor: AppTheme.primary)
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
                  Center(
                    child: Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.back_hand, size: 36, color: AppTheme.primary),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Hands Connect', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  const Text('Plataforma de Aprendizado de Libras', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppTheme.textLight)),
                  const SizedBox(height: 40),
                  
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail')),
                  const SizedBox(height: 14),
                  TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha')),
                  const SizedBox(height: 28),
                  
                  _isLoading 
                      ? const Center(child: CircularProgressIndicator(color: AppTheme.primary)) 
                      : CustomButton(text: 'Entrar', onPressed: _handleLogin),
                  
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen())), 
                    child: const Text('Criar uma conta gratuita', style: TextStyle(color: AppTheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
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
