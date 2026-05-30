import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AiAnalysisResultScreen extends StatelessWidget {
  const AiAnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado del análisis IA')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push('/citizen/report/confirmation'),
          child: const Text('Enviar reporte'),
        ),
      ),
    );
  }
}
