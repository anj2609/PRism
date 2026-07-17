import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_stat_grid.dart';
import '../widgets/recent_activity_list.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../core/theme/app_text_styles.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('PRism')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardSummaryProvider.future),
        child: summaryAsync.when(
          loading: () => const LoadingIndicator(message: 'Syncing repositories...'),
          error: (error, _) => Center(child: Text('$error')),
          data: (summary) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Good Morning Anjali 👋', style: AppTextStyles.heading1(theme.colorScheme.onSurface)),
              const SizedBox(height: 20),
              DashboardStatGrid(summary: summary),
              const SizedBox(height: 24),
              const SectionHeader(title: "Today's Activity"),
              const SizedBox(height: 12),
              const RecentActivityList(
                items: [
                  ActivityItem(icon: Icons.commit, title: 'Recent Commits', subtitle: '5 commits pushed today'),
                  ActivityItem(icon: Icons.rocket_launch_outlined, title: 'Upcoming Releases', subtitle: 'Flutter v2.1 in 2 days'),
                  ActivityItem(icon: Icons.local_fire_department_outlined, title: 'Contribution Streak', subtitle: '27 days in a row'),
                  ActivityItem(icon: Icons.rate_review_outlined, title: 'Recent Reviews', subtitle: '3 reviews submitted'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
