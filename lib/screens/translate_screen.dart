import 'package:flutter/material.dart';
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
