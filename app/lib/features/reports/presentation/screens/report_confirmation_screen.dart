import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportConfirmationScreen extends StatefulWidget {
  const ReportConfirmationScreen({super.key});

  @override
  State<ReportConfirmationScreen> createState() => _ReportConfirmationScreenState();
}

class _ReportConfirmationScreenState extends State<ReportConfirmationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  double _progressValue = 0.0;

  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color riskHighDark = Color(0xFFDC2626);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color bgColor = Color(0xFFF8FAFC);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Initial animations
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _progressValue = 1.0;
        });
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const Icon(Icons.water_drop, color: primaryColor),
        title: const Text(
          'DrenaCruz AI',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: textSub),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Map Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAh8m9_ITMa2iDzN_wvTBI1znKkTRSIJSNAqm8ct71QoarzjQnepJK6Ibmx3IrlxlPgT9ogb9GMQp2aEkMzb4H5E6XqGP2sNsadA9aZ9puJLuQ8nOzwSD8CQTCTwm05b2xPamdAW4faxFoqcjZWre3LWYliK92-37H-jxowYnb4kpjQYvPCSJRSS0ssQzwTHw-mHxWNi8sKOijHLQmnwyhA2uvm1tjsW35gPIAXbctgcZfKJmZkb-HnBTZ3ZDW7ePngSYhgEpMeEbS5',
                fit: BoxFit.cover,
                color: Colors.grey,
                colorBlendMode: BlendMode.saturation,
              ),
            ),
          ),
          
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('PASO 4 DE 4', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textSub, letterSpacing: 1.0)),
                        Text('100%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: secondaryColor)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: _progressValue,
                          child: Container(
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Success Animation
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: secondaryColor.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 48),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Reporte enviado correctamente',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor, height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tu reporte ayudará a priorizar la limpieza preventiva de esta zona.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: textSub),
                    ),
                    const SizedBox(height: 32),

                    // Reference Details
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: const [
                          Text('NÚMERO DE REPORTE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textSub, letterSpacing: 1.0)),
                          SizedBox(height: 4),
                          Text('#DRC-2026-0148', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor, fontFamily: 'monospace')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        border: Border.all(color: const Color(0xFFFEE2E2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(color: riskHigh, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          const Text('Riesgo alto', style: TextStyle(color: riskHighDark, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Gracias por aportar datos para tu barrio.',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: textSub),
                    ),
                    const SizedBox(height: 32),

                    // Actions
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      child: const Text('Ver mi reporte'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => context.go('/citizen/map'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 56),
                        side: const BorderSide(color: primaryColor, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      child: const Text('Volver al inicio'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(foregroundColor: primaryColor),
                      child: const Text('Compartir alerta', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
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
