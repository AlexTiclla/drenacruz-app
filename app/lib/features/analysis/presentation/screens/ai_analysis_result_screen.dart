import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

class AiAnalysisResultScreen extends StatefulWidget {
  const AiAnalysisResultScreen({super.key});

  @override
  State<AiAnalysisResultScreen> createState() => _AiAnalysisResultScreenState();
}

class _AiAnalysisResultScreenState extends State<AiAnalysisResultScreen> {
  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color primaryLight = Color(0xFFE6EFF7);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color surfaceColor = Color(0xFFF8FAFC);
  static const Color nightColor = Color(0xFF0F172A);
  static const Color slateColor = Color(0xFF64748B);

  static const CameraPosition _santaCruz = CameraPosition(
    target: LatLng(-17.695328, -63.151325),
    zoom: 14.0,
  );

  String _selectedProblem = 'Calle inundada';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Resultado del análisis',
              style: TextStyle(
                color: nightColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'PASO 3 DE 4',
              style: TextStyle(
                color: slateColor,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'IA ACTIVA',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: slateColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Preview Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      'http://cd1.eju.tv/wp-content/uploads/2018/01/5a4b9636a72f2.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: const [
                              Icon(Icons.photo_camera, size: 16, color: nightColor),
                              SizedBox(width: 8),
                              Text('Cambiar foto', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: nightColor)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.psychology, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // AI Analysis Panel
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.auto_awesome, color: primaryColor),
                          SizedBox(width: 8),
                          Text('Detección de IA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: nightColor)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFFEE2E2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.warning, color: riskHigh, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'RIESGO VISUAL: ALTO',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: riskHigh,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('TIPO DETECTADO', style: TextStyle(fontSize: 10, color: slateColor, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                            const SizedBox(height: 4),
                            const Text('Calle inundada', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: nightColor)),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text('OBSTRUCCIÓN ESTIMADA', style: TextStyle(fontSize: 10, color: slateColor, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                ),
                                SizedBox(width: 4),
                                Text('100%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: riskHigh)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 0.82,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: riskHigh,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ELEMENTOS IDENTIFICADOS', style: TextStyle(fontSize: 10, color: slateColor, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildChip('Auto'),
                                _buildChip('Agua estancada'),
                                _buildChip('Tunel'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text('NIVEL DE AGUA', style: TextStyle(fontSize: 10, color: slateColor, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(Icons.water_drop, color: secondaryColor, size: 20),
                                SizedBox(width: 4),
                                Text('Muy alto', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: nightColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryLight.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.info, color: primaryColor, size: 18),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'La IA detectó agua estancada y un auto inundado en un túnel.',
                            style: TextStyle(color: primaryColor, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'La IA es una ayuda; puedes corregir el resultado antes de enviarlo.',
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: slateColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Formulario Editable
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Confirmación del reporte', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: nightColor)),
                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 12),
                  const Text('Tipo de problema', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey.shade100),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedProblem,
                        isExpanded: true,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Icon(Icons.expand_more, color: slateColor),
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedProblem = newValue;
                            });
                          }
                        },
                        items: <String>[
                          'Calle inundada',
                          'Canal obstruido',
                          'Desborde de aguas negras',
                          'Infraestructura dañada',
                          'Microbasural'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(value, style: const TextStyle(fontSize: 14)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Comentario adicional', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Ej: La basura está bloqueando el paso del agua bajo el puente...',
                      hintStyle: TextStyle(color: Colors.blueGrey.shade300, fontSize: 14),
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blueGrey.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blueGrey.shade100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Confirmar ubicación', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: IgnorePointer(
                            child: GoogleMap(
                              initialCameraPosition: _santaCruz,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                            ),
                          ),
                        ),
                      ),
                      const Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.location_on, color: primaryColor, size: 48),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.map, size: 16),
                          label: const Text('Ajustar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Acciones principales
            ElevatedButton(
              onPressed: () => context.push('/citizen/report/confirmation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: primaryColor.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: const [
                  Flexible(child: Text('Confirmar y enviar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                  SizedBox(width: 8),
                  Icon(Icons.send, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: slateColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.blueGrey.shade200, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text('Volver a empezar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // slate-100
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF334155), // slate-700
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

