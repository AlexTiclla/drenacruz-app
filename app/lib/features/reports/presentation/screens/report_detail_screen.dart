import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportDetailScreen extends StatelessWidget {
  final String id;
  const ReportDetailScreen({super.key, required this.id});

  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color bgSurface = Colors.white;
  static const Color bgMain = Color(0xFFF8FAFC);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color riskHigh = Color(0xFFDC2626);
  static const Color riskHighBg = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF22C55E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgMain,
      appBar: AppBar(
        backgroundColor: bgSurface.withOpacity(0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Reporte #$id',
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: const NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuD69I162w_Lvh4QUbREXyH6bZGAoTYrKT-Pg3gxx-VSbm1DXTpeBKnZM-A-zC0meJS0fKIj-yXuaMJ8HdHEYeglrikRNNxhRvStkPSKpAfmkdpTdYLK5NNY82vXUZCiNhuvkhT7mN3lQXgOUNGQBZOHGWZbT_cn2n9V2Zsv0in4rw-07X7Tm7UxhquW4mXBoiQMQIdFANIAi4wgr1et6jlz0qQ-nQE7eS83ugVDkQayw0N5l4Bus6y6nso8hYGUTqzsnoawzZR6m9ZC',
              ),
              backgroundColor: Colors.grey.shade200,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Hero Section & Risk Badge
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: bgSurface,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                ],
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida/ADBb0ujFK18f7_wIDT8jtN4j_TFXDHMS5m5mGuMJtUmllq1qDeoFfRlEKyr4p_JbVatsxwdVCL3YOiEokO9a6_At6nUMOC3xILb2i03OuOtDxdjMdyAop-4D9w2xUOKaF3STtWmgFvbnc04G2BGnGFf3GiQmUqBbRpjWqJY05TZC0rcQmAqc8TkZuOfg8JDq--8gyMH2nD1n77q9B57RZk1Qtpdk0aS6BcvFTVRhBS-oF77cVcLgnWs17LcbGOT5',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: riskHigh,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: riskHighBg.withOpacity(0.5), blurRadius: 8, offset: const Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.warning, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('Priorizar acción: Riesgo alto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Location Bento Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: bgSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade50),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.location_on, color: primaryColor),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('UBICACIÓN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textSub, letterSpacing: 1.0)),
                              Text('Canal Av. Beni 5to anillo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textMain)),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                        child: const Text('Ver mapa', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 128,
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.blueGrey.shade100),
                    child: Stack(
                      children: [
                        Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuD2JLqFMiX2JsQcbXF6VO8mNqZPyR2fJJZun_v9As-3ZbFUk0K16ZsA3SVyBLH3BS09BYq60xN_3Zz0F_Tnn_vEYnXREfMQIeQNmckTv9mLDQdi-qh4T7BvjHAcrrUNWkmrBagdXJfWClrTswd-2nLDhKkCfcNAH0y9hmlMThteNBdaTU3Xwb00S6maiNqhJXajhRz8Ep66xuItKZx2wIkxj5vZ4erbRk4I8Fax5RiUW9SNV7iQmiq6Kaq0rOK8MSW4Iblh_mbUjHOL',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white.withOpacity(0.2),
                          colorBlendMode: BlendMode.lighten,
                        ),
                        Center(
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: riskHighBg,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [BoxShadow(color: riskHighBg.withOpacity(0.5), blurRadius: 8)],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // IA Analysis Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]),
                    child: const Icon(Icons.smart_toy, color: primaryColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Análisis IA DrenaCruz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor)),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text('82%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: primaryColor)),
                            const SizedBox(width: 8),
                            Text('Nivel de Obstrucción', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryColor.withOpacity(0.8))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildTag('Basura plástica'),
                            _buildTag('Ramas'),
                            _buildTag('Sedimento'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.verified, size: 16, color: textSub),
                            const SizedBox(width: 4),
                            const Text('Nivel de confianza: media-alta', style: TextStyle(fontSize: 12, color: textSub)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Timeline Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: bgSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade50),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.event_note, color: Colors.black38),
                      SizedBox(width: 8),
                      Text('Seguimiento de Reporte', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textMain)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildTimelineItem(title: 'Reporte recibido', subtitle: '24 de Mayo, 09:12 AM', isCompleted: true),
                  _buildTimelineItem(title: 'Analizado por IA', subtitle: '24 de Mayo, 09:15 AM', isCompleted: true),
                  _buildTimelineItem(title: 'Enviado a operador', subtitle: '24 de Mayo, 10:30 AM', isCompleted: true),
                  _buildTimelineItem(title: 'En revisión', subtitle: 'Asignado a Cuadrilla Zona Norte', isActive: true),
                  _buildTimelineItem(title: 'Atendido / cerrado', subtitle: 'Pendiente de resolución final', isPending: true, isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // CTAs
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/citizen/report/photo'),
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Agregar otra foto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Actualizar información'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textSub,
                    minimumSize: const Size(double.infinity, 56),
                    side: BorderSide(color: Colors.blueGrey.shade200, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go('/citizen/map'),
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: const Text('Volver al mapa', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTimelineItem({required String title, required String subtitle, bool isCompleted = false, bool isActive = false, bool isPending = false, bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor : (isActive ? primaryColor : Colors.grey.shade300),
                    shape: BoxShape.circle,
                    border: Border.all(color: isActive ? Colors.blue.shade100 : Colors.white, width: isActive ? 4 : 2),
                    boxShadow: isActive ? [BoxShadow(color: Colors.blue.shade100, blurRadius: 4)] : [],
                  ),
                  child: isCompleted ? const Icon(Icons.check, size: 10, color: Colors.white) : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? successColor : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                      fontSize: 14,
                      color: isPending ? Colors.grey.shade500 : (isActive ? primaryColor : textMain),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isPending ? Colors.grey.shade400 : (isActive ? primaryColor.withOpacity(0.7) : textSub),
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
            _buildNavItem(icon: Icons.map_outlined, label: 'Mapa', isActive: false, onTap: () => context.go('/citizen/map')),
            _buildNavItem(icon: Icons.add_circle_outline, label: 'Reportar', isActive: false, onTap: () => context.push('/citizen/report')),
            _buildNavItem(icon: Icons.notifications_none, label: 'Alertas', isActive: false, onTap: () => context.push('/citizen/alerts')),
            _buildNavItem(icon: Icons.assessment, label: 'Mis reportes', isActive: true),
            _buildNavItem(icon: Icons.person_outline, label: 'Perfil', isActive: false),
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
