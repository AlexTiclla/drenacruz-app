import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportConfirmationScreen extends StatelessWidget {
  const ReportConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmación')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/citizen/map'),
          child: const Text('Volver al mapa'),
        ),
      ),
    );
  }
}
