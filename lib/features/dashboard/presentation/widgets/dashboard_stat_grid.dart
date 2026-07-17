import 'package:flutter/material.dart';
import '../../domain/models/dashboard_summary_model.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../../../core/theme/app_colors.dart';

class DashboardStatGrid extends StatelessWidget {
  final DashboardSummary summary;

  const DashboardStatGrid({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final items = [
      (label: 'Repositories', value: '${summary.repositoryCount}', icon: Icons.folder_outlined, color: AppColors.primary),
      (label: 'Open PR Reviews', value: '${summary.openPrReviews}', icon: Icons.merge_type, color: AppColors.info),
      (label: 'Assigned Issues', value: '${summary.assignedIssues}', icon: Icons.bug_report_outlined, color: AppColors.warning),
      (label: 'Failed Builds', value: '${summary.failedBuilds}', icon: Icons.error_outline, color: AppColors.danger),
      (label: 'Unread Notifications', value: '${summary.unreadNotifications}', icon: Icons.notifications_outlined, color: AppColors.secondary),
      (label: 'Contribution Streak', value: '${summary.contributionStreak}d', icon: Icons.local_fire_department_outlined, color: AppColors.accent),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return StatCard(label: item.label, value: item.value, icon: item.icon, color: item.color);
      },
    );
  }
}
