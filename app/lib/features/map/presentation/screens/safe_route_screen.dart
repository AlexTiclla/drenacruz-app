import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SafeRouteScreen extends StatefulWidget {
  const SafeRouteScreen({super.key});

  @override
  State<SafeRouteScreen> createState() => _SafeRouteScreenState();
}

class _SafeRouteScreenState extends State<SafeRouteScreen> {
  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color safeGreen = Color(0xFF10B981);

  bool _routeCalculated = false;

  final MapController _mapController = MapController();

  // Coordenadas de ejemplo en Santa Cruz de la Sierra
  final LatLng _startPoint = const LatLng(-17.7800, -63.1800);
  final LatLng _floodedPoint = const LatLng(-17.7850, -63.1820);
  final LatLng _endPoint = const LatLng(-17.7950, -63.1850);

  // Simulación de los puntos que formarían la ruta esquivando la inundación
  final List<LatLng> _routePoints = [
    const LatLng(-17.7800, -63.1800), // Inicio
    const LatLng(-17.7820, -63.1760), // Desvío a la izquierda
    const LatLng(-17.7880, -63.1760), // Bajando por otra calle segura
    const LatLng(-17.7920, -63.1810), // Acercándose al objetivo
    const LatLng(-17.7950, -63.1850), // Destino final
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Capa del Mapa (Real OpenStreetMap)
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _startPoint,
                initialZoom: 14.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.drenacruz.app',
                ),
                if (_routeCalculated)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        color: safeGreen,
                        strokeWidth: 5.0,
                      ),
                    ],
                  ),
                if (_routeCalculated)
                  MarkerLayer(
                    markers: [
                      // Inicio
                      Marker(
                        point: _startPoint,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.my_location, color: primaryColor, size: 30),
                      ),
                      // Zona Inundada (Riesgo Alto)
                      Marker(
                        point: _floodedPoint,
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: riskHigh.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(color: riskHigh, width: 1),
                          ),
                          child: const Icon(Icons.water_drop, color: riskHigh, size: 30),
                        ),
                      ),
                      // Destino
                      Marker(
                        point: _endPoint,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.location_on, color: safeGreen, size: 40),
                      ),
                    ],
                  ),
              ],
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
                          'Evitando zonas de riesgo (OpenStreetMap)',
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
                              _mapController.move(_startPoint, 13.5); // Aleja el zoom para ver la ruta
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
                              _mapController.move(_startPoint, 13.5);
                            });
                          },
                        )
                      else
                        IconButton(
                          icon: const Icon(Icons.close, color: textSub),
                          onPressed: () {
                            setState(() {
                              _routeCalculated = false;
                              _mapController.move(_startPoint, 14.5);
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
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
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
                        'Ruta óptima calculada. Se ha evitado 1 zona de inundación activa en tu trayecto.',
                        style: TextStyle(color: Color(0xFF065F46), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
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
