import 'package:flutter/material.dart';
import '../../domain/models/issue_model.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';

class IssueCard extends StatelessWidget {
  final IssueModel issue;
  final VoidCallback? onTap;

  const IssueCard({super.key, required this.issue, this.onTap});

  Color get _priorityColor {
    switch (issue.priority) {
      case IssuePriority.high:
        return AppColors.danger;
      case IssuePriority.medium:
        return AppColors.warning;
      case IssuePriority.low:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(issue.title, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: _priorityColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                child: Text(issue.priority.name, style: TextStyle(color: _priorityColor, fontSize: 11)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(8)),
                child: Text(issue.label, style: AppTextStyles.caption(theme.colorScheme.onSurface)),
              ),
              if (issue.assigned)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                  child: const Text('Assigned', style: TextStyle(color: AppColors.primary, fontSize: 11)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Created ${AppDateUtils.timeAgo(issue.createdAt)}', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
