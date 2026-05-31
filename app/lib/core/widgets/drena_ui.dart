import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrenaColors {
  static const Color primary = Color(0xFF0B5CAD);
  static const Color secondary = Color(0xFF00A6A6);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color text = Color(0xFF0F172A);
  static const Color subtext = Color(0xFF64748B);
  static const Color riskLow = Color(0xFF22C55E);
  static const Color riskMedium = Color(0xFFF59E0B);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color riskCritical = Color(0xFFDC2626);
}

class DrenaFonts {
  static TextStyle headline({
    double size = 20,
    FontWeight weight = FontWeight.w700,
    Color color = DrenaColors.text,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: 'Plus Jakarta Sans',
    );
  }

  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = DrenaColors.text,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: 'Inter',
    );
  }

  static TextStyle label({
    double size = 12,
    FontWeight weight = FontWeight.w600,
    Color color = DrenaColors.subtext,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      fontFamily: 'Inter',
    );
  }
}

PreferredSizeWidget drenaAppBar({
  required BuildContext context,
  required String title,
  String? subtitle,
  List<Widget> actions = const [],
  VoidCallback? onBack,
  Color titleColor = DrenaColors.text,
  Color subtitleColor = DrenaColors.subtext,
  Color backgroundColor = DrenaColors.surface,
}) {
  return AppBar(
    toolbarHeight: subtitle == null ? 72 : 78,
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
    elevation: 0,
    centerTitle: false,
    leading: onBack == null
        ? null
        : IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
          ),
    titleSpacing: onBack == null ? 16 : 0,
    title: subtitle == null
        ? Text(title, style: DrenaFonts.headline(size: 18, weight: FontWeight.w800, color: titleColor))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: DrenaFonts.headline(size: 18, weight: FontWeight.w800, color: titleColor)),
              const SizedBox(height: 2),
              Text(subtitle, style: DrenaFonts.label(size: 11, weight: FontWeight.w500, color: subtitleColor)),
            ],
          ),
    actions: actions,
  );
}

Widget drenaSectionCard({
  required Widget child,
  EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  Color color = DrenaColors.surface,
  BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(20)),
  Border? border,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow ?? [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 22, offset: const Offset(0, 10)),
      ],
    ),
    child: child,
  );
}

Widget drenaRiskBadge({
  required String label,
  required Color color,
  IconData? icon,
  Color? background,
  bool outlined = true,
}) {
  final Color tint = background ?? color.withOpacity(0.12);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(999),
      border: outlined ? Border.all(color: color.withOpacity(0.18)) : null,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
        ],
        Text(
          label,
          style: DrenaFonts.label(size: 11, weight: FontWeight.w800, color: color, letterSpacing: 0.5),
        ),
      ],
    ),
  );
}

Widget drenaPillButton({
  required String label,
  required IconData icon,
  required VoidCallback onPressed,
  bool filled = true,
  Color color = DrenaColors.primary,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: filled ? color : Colors.white,
      foregroundColor: filled ? Colors.white : color,
      elevation: 0,
      shadowColor: Colors.transparent,
      side: filled ? BorderSide.none : BorderSide(color: color.withOpacity(0.18), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    icon: Icon(icon, size: 18),
    label: Text(label, style: DrenaFonts.body(size: 14, weight: FontWeight.w700, color: filled ? Colors.white : color)),
  );
}

Widget drenaBottomNav(BuildContext context, {required int currentIndex}) {
  final items = [
    ('Home', Icons.map_outlined, '/citizen/map'),
    ('Reportar', Icons.add_circle_outline, '/citizen/report'),
    ('Alertas', Icons.notifications_active_outlined, '/citizen/alerts'),
    ('Reportes', Icons.assignment_outlined, '/citizen/my-reports'),
    ('Perfil', Icons.person_outline, null),
  ];

  return SafeArea(
    top: false,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.06))),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final (label, icon, route) = items[index];
          final bool selected = index == currentIndex;
          final Color color = selected ? DrenaColors.primary : DrenaColors.subtext;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: route == null
                  ? null
                  : () {
                      context.go(route);
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? DrenaColors.primary.withOpacity(0.06) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 24, color: color, fill: selected ? 1 : 0),
                    const SizedBox(height: 2),
                    Text(label, style: DrenaFonts.label(size: 10, weight: selected ? FontWeight.w700 : FontWeight.w500, color: color)),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );
}

Widget drenaSubtleDivider({double height = 1}) {
  return Divider(height: height, thickness: 1, color: Colors.black.withOpacity(0.06));
}