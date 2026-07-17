import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';

class ActivityItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityItem({required this.icon, required this.title, required this.subtitle});
}

class RecentActivityList extends StatelessWidget {
  final List<ActivityItem> items;

  const RecentActivityList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          final item = entry.value;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: isLast ? null : Border(bottom: BorderSide(color: theme.dividerColor)),
            ),
            child: Row(
              children: [
                Icon(item.icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                      Text(item.subtitle, style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
