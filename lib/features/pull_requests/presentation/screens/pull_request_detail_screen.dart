import 'package:flutter/material.dart';
import '../widgets/diff_viewer.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../ai_assistant/presentation/widgets/pr_ai_tab.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class PullRequestDetailScreen extends StatelessWidget {
  final int pullRequestNumber;

  const PullRequestDetailScreen({super.key, required this.pullRequestNumber});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PR #$pullRequestNumber'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Conversation'),
              Tab(text: 'Files Changed'),
              Tab(text: 'Checks'),
              Tab(text: 'Commits'),
              Tab(text: 'Reviews'),
              Tab(text: 'AI'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const _OverviewTab(),
            const _ConversationTab(),
            const _FilesChangedTab(),
            const _ChecksTab(),
            const _CommitsTab(),
            const _ReviewsTab(),
            PrAiTab(pullRequestNumber: pullRequestNumber),
          ],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Google Login', style: AppTextStyles.heading3(theme.colorScheme.onSurface)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.openState.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                    child: const Text('Open', style: TextStyle(color: AppColors.openState, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Description', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
              Text('Adds Google OAuth login using Firebase Authentication.', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              const SizedBox(height: 12),
              Text('Linked Issue: #201', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              Text('Author: John', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              Text('Labels: feature, auth', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              Text('Milestone: v2.1', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConversationTab extends StatelessWidget {
  const _ConversationTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John commented', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
              const SizedBox(height: 4),
              Text('Ready for review.', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilesChangedTab extends StatelessWidget {
  const _FilesChangedTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DiffViewer(
          fileName: 'lib/auth/login.dart',
          lines: const [
            DiffLine(content: 'class LoginPage extends StatelessWidget {', oldLineNumber: 10, newLineNumber: 10, type: DiffLineType.context),
            DiffLine(content: 'final auth = FirebaseAuth.instance;', newLineNumber: 11, type: DiffLineType.addition),
            DiffLine(content: 'final auth = MockAuth();', oldLineNumber: 11, type: DiffLineType.deletion),
          ],
        ),
      ],
    );
  }
}

class _ChecksTab extends StatelessWidget {
  const _ChecksTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final checks = const [
      ('Android Build', true),
      ('Unit Test', true),
      ('Lint', true),
      ('Coverage', true),
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: checks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final check = checks[index];
        return AppCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(check.$1, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(check.$1 == 'Coverage' ? '92%' : 'Passed', style: AppTextStyles.caption(AppColors.success)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommitsTab extends StatelessWidget {
  const _CommitsTab();

  @override
  Widget build(BuildContext context) {
    final commits = const ['Fix Login', 'Refactor Auth', 'Remove Bugs'];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: commits.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => AppCard(child: Text(commits[index])),
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCard(
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: 8),
              Text('Priya approved these changes', style: AppTextStyles.body(theme.colorScheme.onSurface)),
            ],
          ),
        ),
      ],
    );
  }
}
