import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';

class IssueDetailScreen extends StatelessWidget {
  final int issueNumber;

  const IssueDetailScreen({super.key, required this.issueNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Issue #$issueNumber')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                const SizedBox(height: 8),
                Text('App crashes when logging in with an expired session token.', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Assignee: Anjali', style: AppTextStyles.body(theme.colorScheme.onSurface)),
                Text('Labels: Bug, High Priority', style: AppTextStyles.body(theme.colorScheme.onSurface)),
                Text('Milestone: v2.1', style: AppTextStyles.body(theme.colorScheme.onSurface)),
                Text('Linked PR: #224', style: AppTextStyles.body(theme.colorScheme.onSurface)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Timeline', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                const SizedBox(height: 8),
                Text('Opened by Anjali yesterday', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
