import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NearbyAlertsScreen extends StatelessWidget {
  const NearbyAlertsScreen({super.key});

  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color riskMedium = Color(0xFFF59E0B);
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const Icon(Icons.water_drop, color: primaryColor),
        title: const Text(
          'Alertas cercanas',
          style: TextStyle(
            color: textMain,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor.withOpacity(0.1), width: 2),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCzkV5glsOQIFesYanemGCVKai97O1Fx7gaAkVADzbqK2BDgrF1EaJaPGEyg5W_P5HbmUJ7zGlkojIuAM_FaSPNDG8jxxXBMFqxwEzy6KLCph1Ag6bKq_SEFVSNk8uzuP6TSqEmyQAhrI5mUoO5mqBEXIkOLARo56VBCt53CFNzgSLc8Lmq09grxG68yMtLFzk1QTM2mWolVPP4PKY8BsbW4_es-qV8opjIeUhF4TLJfvTJKHkTDJg6JdL_13V5zJUlebSKeZCt-AEl'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Alert Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFFEF2F2), // red-50
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(8),
                  left: Radius.circular(4),
                ),
                border: Border(
                  left: BorderSide(color: riskHigh, width: 4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_rounded, color: riskHigh, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Riesgo alto de anegamiento en tu zona durante las próximas 2 horas.',
                          style: TextStyle(
                            color: Color(0xFFB91C1C), // red-700
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Nivel freático elevado por lluvias persistentes.',
                          style: TextStyle(
                            color: Color(0xFFB91C1C),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Reportes Recientes Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Reportes recientes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textMain,
                  ),
                ),
                Text(
                  'Actualizado hace 2 min',
                  style: TextStyle(fontSize: 12, color: textSub, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Card 1
            _buildReportCard(
              zona: 'Av. Beni 5to anillo',
              badgeText: 'PRIORIZAR ACCIÓN',
              badgeColor: riskHigh,
              badgeBg: const Color(0xFFFEE2E2),
              motivo: 'Obstrucción + lluvia prevista',
              recomendacion: 'Evite circular por calles cercanas al canal',
              tiempo: 'hace 20 min',
            ),
            const SizedBox(height: 12),

            // Card 2
            _buildReportCard(
              zona: 'Doble vía La Guardia',
              badgeText: 'PRIORIZAR ACCIÓN',
              badgeColor: riskHigh,
              badgeBg: const Color(0xFFFEE2E2),
              motivo: 'Cruce anegable + sedimento',
              recomendacion: 'No se acerque al canal',
              tiempo: 'hace 1 h',
            ),
            const SizedBox(height: 12),

            // Card 3
            _buildReportCard(
              zona: 'Plan 3000 canal secundario',
              badgeText: 'REQUIERE MONITOREO',
              badgeColor: riskMedium,
              badgeBg: const Color(0xFFFEF3C7),
              motivo: 'Maleza acumulada',
              recomendacion: 'Reporte si observa bloqueo',
              tiempo: 'hace 2 h',
            ),
            const SizedBox(height: 24),

            // Zonas a evitar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.dangerous, color: riskHigh),
                      SizedBox(width: 8),
                      Text(
                        'Zonas a evitar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildAvoidZoneItem('1', 'Intersección Cristo Redentor y 4to anillo', riskHigh),
                  const SizedBox(height: 12),
                  _buildAvoidZoneItem('2', 'Bajo del canal Isuto (6to anillo)', riskHigh),
                  const SizedBox(height: 12),
                  _buildAvoidZoneItem('3', 'Santos Dumont y Curva del Abasto', riskMedium, textColor: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Toggle Config
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueGrey.shade50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: const [
                        Icon(Icons.notifications_active_outlined, color: textSub),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Activar notificaciones críticas',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textMain),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: Colors.white,
                    activeTrackColor: primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Main action button
            ElevatedButton.icon(
              onPressed: () {
                context.go('/citizen/map');
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('Ver en mapa de riesgo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildReportCard({
    required String zona,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBg,
    required String motivo,
    required String recomendacion,
    required String tiempo,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Zona',
                      style: TextStyle(fontSize: 12, color: textSub, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      zona,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textMain),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: textSub),
              const SizedBox(width: 8),
              Text.rich(
                TextSpan(
                  text: 'Motivo: ',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  children: [
                    TextSpan(
                      text: motivo,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                style: const TextStyle(color: textSub),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline, size: 16, color: primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Recomendación: ',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: 13),
                      children: [
                        TextSpan(
                          text: recomendacion,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: textMain),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: bgColor, thickness: 2),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.schedule, size: 14, color: textSub),
                  const SizedBox(width: 4),
                  Text(
                    tiempo,
                    style: const TextStyle(fontSize: 12, color: textSub),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: primaryColor,
                ),
                child: Row(
                  children: const [
                    Text('DETALLES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Icon(Icons.chevron_right, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvoidZoneItem(String number, String text, Color color, {Color textColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.map_outlined, label: 'Home', isActive: false, onTap: () => context.go('/citizen/map')),
            _buildNavItem(icon: Icons.add_circle_outline, label: 'Reportar', isActive: false, onTap: () => context.push('/citizen/report')),
            _buildNavItem(icon: Icons.notifications_active, label: 'Alertas', isActive: true, onTap: () {}),
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

