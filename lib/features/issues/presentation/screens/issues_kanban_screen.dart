import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/issue_provider.dart';
import '../widgets/issue_card.dart';
import '../../domain/models/issue_model.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../core/theme/app_text_styles.dart';

class IssuesKanbanScreen extends ConsumerWidget {
  const IssuesKanbanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final issuesAsync = ref.watch(issueListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Issues')),
      body: issuesAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => Center(child: Text('$error')),
        data: (issues) {
          return Row(
            children: [
              _KanbanColumn(
                title: 'Open',
                issues: issues.where((issue) => issue.column == IssueColumn.open).toList(),
              ),
              _KanbanColumn(
                title: 'In Progress',
                issues: issues.where((issue) => issue.column == IssueColumn.inProgress).toList(),
              ),
              _KanbanColumn(
                title: 'Closed',
                issues: issues.where((issue) => issue.column == IssueColumn.closed).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _KanbanColumn extends StatelessWidget {
  final String title;
  final List<IssueModel> issues;

  const _KanbanColumn({required this.title, required this.issues});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text('$title (${issues.length})', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: issues.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final issue = issues[index];
                  return IssueCard(
                    issue: issue,
                    onTap: () => context.push('/issues/${issue.number}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
