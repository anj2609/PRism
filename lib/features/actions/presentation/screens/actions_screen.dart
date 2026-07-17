import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/workflow_run_provider.dart';
import '../../domain/models/workflow_run_model.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class ActionsScreen extends ConsumerWidget {
  const ActionsScreen({super.key});

  Color _statusColor(WorkflowStatus status) {
    switch (status) {
      case WorkflowStatus.passed:
        return AppColors.success;
      case WorkflowStatus.failed:
        return AppColors.danger;
      case WorkflowStatus.running:
        return AppColors.warning;
    }
  }

  String _statusLabel(WorkflowStatus status) {
    switch (status) {
      case WorkflowStatus.passed:
        return 'Passed';
      case WorkflowStatus.failed:
        return 'Failed';
      case WorkflowStatus.running:
        return 'Running';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runsAsync = ref.watch(workflowRunListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Actions')),
      body: runsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => Center(child: Text('$error')),
        data: (runs) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: runs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final run = runs[index];
            return AppCard(
              onTap: () => context.push('/actions/${run.id}'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(run.name, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                      Text('${run.branch} • ${run.commitMessage}', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: _statusColor(run.status).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                    child: Text(_statusLabel(run.status), style: TextStyle(color: _statusColor(run.status), fontSize: 12)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
