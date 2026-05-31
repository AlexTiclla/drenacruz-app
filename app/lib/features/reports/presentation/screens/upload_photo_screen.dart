import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _isAnalyzing = false;
  String _analysisText = '';

  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color bgColor = Color(0xFFF8FAFC);

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() => _image = photo);
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() => _image = photo);
    }
  }

  void _startAnalysis() {
    if (_image == null) {
      // In a real app, require image. Using demo flow.
    }
    setState(() {
      _isAnalyzing = true;
      _analysisText = "Iniciando reconocimiento visual...";
    });

    final messages = [
      "Analizando basura y maleza...",
      "Escaneando sedimento y obstrucciones...",
      "Calculando nivel de agua y riesgo...",
      "Finalizando diagnóstico preventivo..."
    ];

    int i = 0;
    Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (i < messages.length) {
        setState(() {
          _analysisText = messages[i];
        });
        i++;
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _isAnalyzing = false;
            });
            context.push('/citizen/report/analysis');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textMain),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Sube una foto del punto crítico',
          style: TextStyle(
            color: textMain,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Step Indicator
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('PASO 2 DE 4', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textSub, letterSpacing: 1.0)),
                        Text('50% completado', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Upload Container
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blueGrey.shade200, width: 2, style: BorderStyle.solid), // In real css it's dashed, using solid here for simplicity or customize later
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_enhance, color: primaryColor, size: 32),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Captura la evidencia',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textMain),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'La IA analizará la imagen para detectar obstrucciones y niveles de riesgo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: textSub),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _takePhoto,
                        icon: const Icon(Icons.photo_camera),
                        label: const Text('Tomar foto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 4,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: _pickFromGallery,
                        icon: const Icon(Icons.file_upload),
                        label: const Text('Subir desde galería'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          minimumSize: const Size(double.infinity, 56),
                          side: BorderSide(color: primaryColor.withOpacity(0.2), width: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Image Preview
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('VISTA PREVIA DEL REPORTE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textSub, letterSpacing: -0.5)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(4)),
                              child: const Text('Imagen detectada', style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: 1.5,
                                child: Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                onPressed: () {
                                  setState(() => _image = null);
                                },
                                icon: const Icon(Icons.delete, color: riskHigh, size: 20),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.9),
                                  padding: const EdgeInsets.all(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                // Visual Tips Card
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 100),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blueGrey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.lightbulb, color: secondaryColor),
                          SizedBox(width: 8),
                          Text('Consejos para una mejor captura', style: TextStyle(fontWeight: FontWeight.bold, color: textMain)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTip(Icons.check, secondaryColor, 'Incluye el canal completo si es posible.'),
                      const SizedBox(height: 12),
                      _buildTip(Icons.check, secondaryColor, 'Evita fotos borrosas.'),
                      const SizedBox(height: 12),
                      _buildTip(Icons.warning, riskHigh, 'No pongas en riesgo tu seguridad.', isBold: true),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sticky Bottom Action
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border(top: BorderSide(color: Colors.blueGrey.shade50)),
              ),
              child: SafeArea(
                child: ElevatedButton.icon(
                  onPressed: _startAnalysis,
                  icon: const Icon(Icons.psychology),
                  label: const Text('Analizar con IA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 8,
                    shadowColor: primaryColor.withOpacity(0.5),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // Loading Overlay
          if (_isAnalyzing)
            Container(
              color: Colors.white.withOpacity(0.95),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 96,
                          height: 96,
                          child: CircularProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                            strokeWidth: 4,
                            backgroundColor: Colors.blueGrey.shade100,
                          ),
                        ),
                        const Icon(Icons.analytics, color: primaryColor, size: 36),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text('Analizando reporte...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textMain)),
                    const SizedBox(height: 16),
                    Text(_analysisText, style: const TextStyle(color: textSub, fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // Real shimmer would need a package, simple linear progress for now
                      child: const LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTip(IconData icon, Color color, String text, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textMain,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
