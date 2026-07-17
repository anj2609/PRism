import 'package:flutter/material.dart';
import '../../domain/models/pull_request_model.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class PullRequestCard extends StatelessWidget {
  final PullRequestModel pullRequest;
  final VoidCallback? onTap;

  const PullRequestCard({super.key, required this.pullRequest, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('#${pullRequest.number}', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.5))),
              const Spacer(),
              Icon(
                pullRequest.ciPassed ? Icons.check_circle : Icons.cancel,
                size: 16,
                color: pullRequest.ciPassed ? AppColors.success : AppColors.danger,
              ),
              const SizedBox(width: 4),
              Text(pullRequest.ciPassed ? 'CI Passed' : 'CI Failed', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
            ],
          ),
          const SizedBox(height: 8),
          Text(pullRequest.title, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(radius: 10, backgroundColor: AppColors.primary.withValues(alpha: 0.2), child: Text(pullRequest.author[0], style: const TextStyle(fontSize: 11))),
              const SizedBox(width: 8),
              Text(pullRequest.author, style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              const SizedBox(width: 12),
              Text('${pullRequest.filesChanged} files', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              const SizedBox(width: 12),
              Text('+${pullRequest.additions}', style: const TextStyle(color: AppColors.success, fontSize: 12)),
              const SizedBox(width: 4),
              Text('-${pullRequest.deletions}', style: const TextStyle(color: AppColors.danger, fontSize: 12)),
            ],
          ),
          if (pullRequest.aiSummaryAvailable) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.auto_awesome, size: 14, color: AppColors.primary),
                const SizedBox(width: 4),
                Text('AI Summary Available', style: AppTextStyles.caption(AppColors.primary)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
