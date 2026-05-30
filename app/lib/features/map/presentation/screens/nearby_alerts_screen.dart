import 'package:flutter/material.dart';

class NearbyAlertsScreen extends StatelessWidget {
  const NearbyAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas Cercanas')),
      body: const Center(child: Text('Alertas Cercanas')),
    );
  }
}
