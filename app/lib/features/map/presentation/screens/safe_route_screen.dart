import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SafeRouteScreen extends StatefulWidget {
  const SafeRouteScreen({super.key});

  @override
  State<SafeRouteScreen> createState() => _SafeRouteScreenState();
}

class _SafeRouteScreenState extends State<SafeRouteScreen> {
  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color riskMedium = Color(0xFFF59E0B);
  static const Color safeGreen = Color(0xFF10B981);

  bool _routeCalculated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Simulando el fondo del mapa
      body: Stack(
        children: [
          // Capa del Mapa (Simulado para demostración)
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE5E5E5),
              child: Stack(
                children: [
                  // Aquí iría el widget de mapa (ej. flutter_map o GoogleMap)
                  // Mocks de rutas y puntos
                  if (_routeCalculated) ...[
                    // Marcador de inicio
                    Positioned(
                      bottom: 200,
                      left: 100,
                      child: Icon(Icons.location_history, color: primaryColor, size: 40),
                    ),
                    // Marcador de zona inundada
                    Positioned(
                      bottom: 350,
                      left: 180,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: riskHigh.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.water_drop, color: riskHigh, size: 40),
                      ),
                    ),
                    // Marcador de destino
                    Positioned(
                      bottom: 500,
                      left: 200,
                      child: Icon(Icons.location_on, color: safeGreen, size: 40),
                    ),
                    // Línea de ruta segura (simulada)
                    Positioned(
                      bottom: 220,
                      left: 120,
                      child: CustomPaint(
                        size: const Size(100, 300),
                        painter: _RoutePainter(),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),

          // Top App Bar Area Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.95),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 12, left: 16, right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: primaryColor),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RUTAS SEGURAS',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Evitando zonas de riesgo',
                          style: TextStyle(color: textSub, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buscador de destino
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.my_location, color: primaryColor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: 'Mi Ubicación actual',
                          enabled: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 14, color: textSub),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: riskHigh, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: '¿A dónde quieres ir?',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14, color: textSub),
                          ),
                          style: const TextStyle(fontSize: 14, color: textMain),
                          onFieldSubmitted: (value) {
                            setState(() {
                              _routeCalculated = true;
                            });
                          },
                        ),
                      ),
                      if (!_routeCalculated)
                        IconButton(
                          icon: const Icon(Icons.search, color: primaryColor),
                          onPressed: () {
                            setState(() {
                              _routeCalculated = true;
                            });
                          },
                        )
                      else
                        IconButton(
                          icon: const Icon(Icons.close, color: textSub),
                          onPressed: () {
                            setState(() {
                              _routeCalculated = false;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Banner de Alerta cuando se calcula la ruta
          if (_routeCalculated)
            Positioned(
              top: MediaQuery.of(context).padding.top + 200,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // emerald-50
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA7F3D0)), // emerald-200
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, color: safeGreen),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Ruta óptima calculada. Se ha evitado 1 zona de inundación activa en el 4to Anillo.',
                        style: TextStyle(color: Color(0xFF065F46), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),

          // Panel de detalles en la parte inferior
          if (_routeCalculated)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '25 min',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: safeGreen,
                                  ),
                                ),
                                Text(
                                  '7.2 km • Ruta segura',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textSub,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.navigation),
                              label: const Text('Iniciar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Pintor simulado para la línea de ruta
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF10B981) // safeGreen
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(50, 100, -50, 150);
    path.quadraticBezierTo(-100, 200, 80, 280);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
