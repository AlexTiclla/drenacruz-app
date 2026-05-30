import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/map/presentation/screens/risk_map_screen.dart';
import '../../features/map/presentation/screens/nearby_alerts_screen.dart';
import '../../features/reports/presentation/screens/report_critical_point_screen.dart';
import '../../features/reports/presentation/screens/upload_photo_screen.dart';
import '../../features/reports/presentation/screens/report_confirmation_screen.dart';
import '../../features/reports/presentation/screens/my_reports_screen.dart';
import '../../features/reports/presentation/screens/report_detail_screen.dart';
import '../../features/analysis/presentation/screens/ai_analysis_result_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/citizen/map',
      builder: (context, state) => const RiskMapScreen(),
    ),
    GoRoute(
      path: '/citizen/alerts',
      builder: (context, state) => const NearbyAlertsScreen(),
    ),
    GoRoute(
      path: '/citizen/report',
      builder: (context, state) => const ReportCriticalPointScreen(),
    ),
    GoRoute(
      path: '/citizen/report/photo',
      builder: (context, state) => const UploadPhotoScreen(),
    ),
    GoRoute(
      path: '/citizen/report/analysis',
      builder: (context, state) => const AiAnalysisResultScreen(),
    ),
    GoRoute(
      path: '/citizen/report/confirmation',
      builder: (context, state) => const ReportConfirmationScreen(),
    ),
    GoRoute(
      path: '/citizen/my-reports',
      builder: (context, state) => const MyReportsScreen(),
    ),
    GoRoute(
      path: '/citizen/reports/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ReportDetailScreen(id: id);
      },
    ),
  ],
);
