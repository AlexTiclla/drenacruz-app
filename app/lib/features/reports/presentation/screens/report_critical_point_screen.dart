import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportCriticalPointScreen extends StatelessWidget {
  const ReportCriticalPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportar punto crítico')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.push('/citizen/report/photo'),
          child: const Text('Continuar con foto'),
        ),
      ),
    );
  }
}
