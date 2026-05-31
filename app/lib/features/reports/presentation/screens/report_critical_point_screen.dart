import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportCriticalPointScreen extends StatefulWidget {
  const ReportCriticalPointScreen({super.key});

  @override
  State<ReportCriticalPointScreen> createState() => _ReportCriticalPointScreenState();
}

class _ReportCriticalPointScreenState extends State<ReportCriticalPointScreen> {
  static const Color primaryColor = Color(0xFF0B5CAD);
  static const Color secondaryColor = Color(0xFF00A6A6);
  static const Color bgMain = Color(0xFFF8FAFC);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);

  int? _selectedIssueIndex;

  final List<Map<String, dynamic>> _issueTypes = [
    {'icon': Icons.delete_outline, 'label': 'Canal con basura'},
    {'icon': Icons.grass, 'label': 'Canal con maleza'},
    {'icon': Icons.terrain, 'label': 'Canal con sedimento'},
    {'icon': Icons.flood, 'label': 'Calle inundada'},
    {'icon': Icons.pool, 'label': 'Agua estancada'},
    {'icon': Icons.help_outline, 'label': 'No estoy seguro'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgMain,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textMain),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Reportar punto crítico',
          style: TextStyle(
            color: textMain,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: primaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Indicator
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'PASO 1 DE 4',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textSub,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.25,
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
                ),
                const SizedBox(height: 32),

                // Hero Question
                const Text(
                  '¿Qué tipo de problema observas?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textMain,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Selecciona la opción que mejor describa la situación actual del canal o drenaje.',
                  style: TextStyle(
                    fontSize: 14,
                    color: textSub,
                  ),
                ),
                const SizedBox(height: 24),

                // Issue Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _issueTypes.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedIssueIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIssueIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withOpacity(0.05) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.blueGrey.shade100,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            if (!isSelected)
                              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor.withOpacity(0.1) : Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _issueTypes[index]['icon'],
                                color: primaryColor,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _issueTypes[index]['label'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: textMain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Location Section
                const Text(
                  'Ubicación',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textMain,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.my_location, color: secondaryColor),
                  label: const Text('Usar mi ubicación actual'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textMain,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    side: BorderSide(color: Colors.blueGrey.shade200),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.map, color: secondaryColor),
                  label: const Text('Elegir en mapa'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textMain,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    side: BorderSide(color: Colors.blueGrey.shade200),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline, size: 16, color: textSub),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Necesitamos una ubicación para priorizar el reporte.',
                        style: TextStyle(fontSize: 12, color: textSub),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Optional Comments
                const Text(
                  'Comentario corto (opcional)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textMain,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Escribe detalles adicionales aquí...',
                    hintStyle: const TextStyle(color: textSub, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.blueGrey.shade200)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryColor)),
                  ),
                ),
              ],
            ),
          ),
          
          // Fixed Action Bottom Section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.blueGrey.shade100)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: _selectedIssueIndex != null
                        ? () => context.push('/citizen/report/photo')
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor: primaryColor.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: _selectedIssueIndex != null ? 4 : 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Continuar con foto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: textSub,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
