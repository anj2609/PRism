import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/contribution_heatmap.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Weekly Pull Requests'),
          const SizedBox(height: 12),
          AppCard(
            child: SizedBox(
              height: 160,
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  barGroups: [4, 6, 3, 8, 5, 2, 7]
                      .asMap()
                      .entries
                      .map((entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [BarChartRodData(toY: entry.value.toDouble(), color: AppColors.primary, width: 16, borderRadius: BorderRadius.circular(4))],
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Contribution Heatmap'),
          const SizedBox(height: 12),
          AppCard(
            child: ContributionHeatmap(weeklyContributions: List.generate(35, (index) => (index * 3) % 8)),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Overview'),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatRow(label: 'Average Review Time', value: '3h 20m'),
                _StatRow(label: 'Commits This Week', value: '42'),
                _StatRow(label: 'Issues Closed', value: '11'),
                _StatRow(label: 'Build Success Rate', value: '94%'),
                _StatRow(label: 'Coding Hours', value: '28h'),
                _StatRow(label: 'Top Language', value: 'Dart'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          Text(value, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
        ],
      ),
    );
  }
}
