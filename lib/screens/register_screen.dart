import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget { 
  const RegisterScreen({super.key}); 
  @override State<RegisterScreen> createState() => _RegisterScreenState(); 
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController(); 
  final _emailController = TextEditingController(); 
  final _passwordController = TextEditingController(); 
  bool _isLoading = false;

  void _handleRegister() async {
    if (_userController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) return;
    setState(() => _isLoading = true);
    final success = await AuthService.instance.register(_userController.text, _emailController.text, _passwordController.text);
    setState(() => _isLoading = false);
    if (success && mounted) { 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Identidade criada com sucesso!'), backgroundColor: AppTheme.primary)); 
      Navigator.of(context).pop(); 
    }
  }

  @override Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Nova Identidade', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            const SizedBox(height: 6),
            const Text('Preencha os campos para ingressar no sistema.', style: TextStyle(color: AppTheme.textLight, fontSize: 14)),
            const SizedBox(height: 32),
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'Nome de Usuário')), 
            const SizedBox(height: 14), 
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Endereço de E-mail')), 
            const SizedBox(height: 14), 
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha Secreta')), 
            const SizedBox(height: 28), 
            _isLoading ? const Center(child: CircularProgressIndicator(color: AppTheme.secondary)) : CustomButton(text: 'Confirmar Cadastro', onPressed: _handleRegister)
          ]
        )
      )
    ); 
  }
}
