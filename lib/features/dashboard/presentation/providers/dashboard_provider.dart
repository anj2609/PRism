import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/dashboard_summary_model.dart';

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return const DashboardSummary(
    repositoryCount: 18,
    openPrReviews: 6,
    assignedIssues: 4,
    failedBuilds: 2,
    unreadNotifications: 12,
    contributionStreak: 27,
  );
});
