import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color bgColor = Color(0xFFF8FAFC);
  
  String _activeFilter = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/citizen/map');
            }
          },
        ),
        title: const Text(
          'Mis reportes',
          style: TextStyle(
            color: textMain,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header with shadow
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildFilterChip('Todos', isActive: _activeFilter == 'Todos'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pendientes', isActive: _activeFilter == 'Pendientes'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Solucionados', isActive: _activeFilter == 'Solucionados'),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildReportCard(
                  location: 'Barrio Conavi',
                  status: 'Pendiente',
                  date: 'Hoy, 10:45 AM',
                  description: 'Canal obstruido con mucha basura plástica. El agua ya está llegando al nivel de la calle y empezó a llover fuerte.',
                  riskLevel: 'Riesgo alto',
                  imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
                  supports: 3,
                ),
                const SizedBox(height: 16),
                _buildReportCard(
                  location: '4to Anillo Radial 13',
                  status: 'Solucionado',
                  date: '12 Oct, 2026',
                  description: 'Sumidero tapado por tierra y hojas. Se inunda esta esquina cada vez que llueve más de media hora.',
                  riskLevel: 'Riesgo medio',
                  imageUrl: 'https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
                  supports: 12,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildFilterChip(String label, {required bool isActive}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : const Color(0xFFF1F5F9), // bg-slate-100 fallback
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF475569), // text-slate-600 fallback
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required String location,
    required String status,
    required String date,
    required String description,
    required String riskLevel,
    required String imageUrl,
    required int supports,
  }) {
    final bool isResolved = status == 'Solucionado';
    
    // Status colors
    final Color statusBg = isResolved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF9C3);
    final Color statusText = isResolved ? const Color(0xFF166534) : const Color(0xFF854D0E);
    
    // Risk colors
    final bool isHighRisk = riskLevel == 'Riesgo alto';
    final Color riskBg = isHighRisk ? const Color(0xFFFEE2E2) : const Color(0xFFFEF9C3);
    final Color riskText = isHighRisk ? const Color(0xFFB91C1C) : const Color(0xFFA16207);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textMain),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: const TextStyle(fontSize: 12, color: textSub),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Card Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFF334155), fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: riskBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          riskLevel,
                          style: TextStyle(
                            color: riskText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Card Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text(
                    'Ver detalle',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.thumb_up_alt_outlined, size: 16, color: textSub),
                    const SizedBox(width: 4),
                    Text(
                      '$supports apoyos',
                      style: const TextStyle(fontSize: 12, color: textSub),
                    ),
                  ],
                ),
              ],
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
            _buildNavItem(icon: Icons.assessment, label: 'Reportes', isActive: true, onTap: () => context.push('/citizen/my-reports')),
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

