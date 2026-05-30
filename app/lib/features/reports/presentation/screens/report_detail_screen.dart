import 'package:flutter/material.dart';

class ReportDetailScreen extends StatelessWidget {
  final String id;
  const ReportDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de reporte #$id')),
      body: Center(child: Text('Detalle de reporte #$id')),
    );
  }
}
