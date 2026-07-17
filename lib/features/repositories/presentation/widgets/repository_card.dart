import 'package:flutter/material.dart';
import '../../domain/models/repository_model.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';

class RepositoryCard extends StatelessWidget {
  final RepositoryModel repository;
  final VoidCallback? onTap;

  const RepositoryCard({super.key, required this.repository, this.onTap});

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
              Expanded(
                child: Text(repository.name, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
              ),
              Icon(
                repository.isPrivate ? Icons.lock_outline : Icons.public,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _MetaChip(icon: Icons.star_border, label: '${repository.stars}'),
              const SizedBox(width: 16),
              _MetaChip(icon: Icons.call_split, label: '${repository.forks}'),
              const SizedBox(width: 16),
              _MetaChip(icon: Icons.merge_type, label: 'PR ${repository.openPrCount}'),
              const SizedBox(width: 16),
              _MetaChip(icon: Icons.bug_report_outlined, label: 'Issues ${repository.openIssueCount}'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Updated ${AppDateUtils.timeAgo(repository.updatedAt)}',
            style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
      ],
    );
  }
}
