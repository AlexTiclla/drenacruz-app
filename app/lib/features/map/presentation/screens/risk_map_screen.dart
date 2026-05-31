import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

class RiskMapScreen extends StatefulWidget {
  const RiskMapScreen({super.key});

  @override
  State<RiskMapScreen> createState() => _RiskMapScreenState();
}

class _RiskMapScreenState extends State<RiskMapScreen> {
  static const CameraPosition _santaCruz = CameraPosition(
    target: LatLng(-17.7833, -63.1821),
    zoom: 13.0,
  );

  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color riskMedium = Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Map Layer
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: _santaCruz,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: primaryColor),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'DRENACRUZ AI',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Santa Cruz de la Sierra',
                            style: TextStyle(color: textSub, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: textSub),
                        onPressed: () => context.push('/citizen/alerts'),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: riskHigh,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Alert Banner Overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB), // amber-50
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFEF3C7)), // amber-100
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
                  const Icon(Icons.warning, color: riskMedium),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Riesgo alto de anegamiento en tu zona durante las próximas 2 horas.',
                      style: TextStyle(color: Color(0xFF78350F), fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    child: const Icon(Icons.close, size: 18, color: Color(0xFF92400E)),
                  )
                ],
              ),
            ),
          ),
          
          // Filter Chips Outline
          Positioned(
            top: MediaQuery.of(context).padding.top + 135,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('Todos', icon: Icons.filter_list, isSelected: true),
                  _buildFilterChip('Basura'),
                  _buildFilterChip('Inundación'),
                  _buildFilterChip('Maleza'),
                  _buildFilterChip('Sedimento'),
                ],
              ),
            ),
          ),

          // Map UI Controls (Zoom, My Location)
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 200,
            child: Column(
              children: [
                _buildMapControlButton(Icons.add),
                const SizedBox(height: 8),
                _buildMapControlButton(Icons.remove),
                const SizedBox(height: 16),
                _buildMapControlButton(Icons.my_location, color: primaryColor),
              ],
            ),
          ),

          // Floating Action Button
          Positioned(
            bottom: 150,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_circle),
              label: const Text('Reportar problema'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),

          // Bottom Sheet Segment
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Weather Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blueGrey.shade100),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('CLIMA EN SANTA CRUZ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textSub)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Text('28°C', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: primaryColor)),
                                      SizedBox(width: 8),
                                      Icon(Icons.water_drop, color: riskMedium),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text('Tormenta eléctrica dispersa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            Container(width: 1, height: 60, color: Colors.blueGrey.shade200),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('LLUVIA PREVISTA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textSub)),
                                  SizedBox(height: 4),
                                  Text('85%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: secondaryColor)),
                                  SizedBox(height: 4),
                                  Text('Precipitación intensa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: riskMedium)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Top Zonas Críticas
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: const [
                          Text('Top 3 zonas críticas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textMain)),
                        ],
                      ),
                    ),
                    // Zone 1
                    _buildCriticalZone('Canal Av. Beni (5to Anillo)', 'Obstrucción por basura detectada', Icons.water_damage, riskHigh, 'ALTO'),
                    _buildCriticalZone('Doble Vía La Guardia', 'Paso bajo nivel crítico', Icons.warning, riskHigh, 'ALTO'),
                    _buildCriticalZone('Plan 3000 (Zanjón)', 'Maleza y sedimentos', Icons.cleaning_services, riskMedium, 'MEDIO'),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNav(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {IconData? icon, bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade300),
        boxShadow: isSelected
            ? [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))]
            : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1))],
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: isSelected ? Colors.white : textSub),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : textSub,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControlButton(IconData icon, {Color color = textMain}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildCriticalZone(String title, String subtitle, IconData icon, Color color, String badgeText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueGrey.shade50),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(subtitle, style: const TextStyle(color: textSub, fontSize: 11)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Text(
                badgeText,
                style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.map, label: 'Mapa', isActive: true, onTap: () {}),
            _buildNavItem(icon: Icons.add_circle_outline, label: 'Reportar', isActive: false, onTap: () => context.push('/citizen/report')),
            _buildNavItem(icon: Icons.notifications_none, label: 'Alertas', isActive: false, onTap: () => context.push('/citizen/alerts')),
            _buildNavItem(icon: Icons.assignment_outlined, label: 'Reportes', isActive: false, onTap: () => context.push('/citizen/my-reports')),
            _buildNavItem(icon: Icons.person_outline, label: 'Perfil', isActive: false, onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required bool isActive, VoidCallback? onTap}) {
    final color = isActive ? primaryColor : textSub;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: isActive ? 28 : 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

