import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';

class PipelineDetailScreen extends StatelessWidget {
  final int workflowRunId;

  const PipelineDetailScreen({super.key, required this.workflowRunId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Run #$workflowRunId')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Duration: 4m 12s', style: AppTextStyles.body(theme.colorScheme.onSurface)),
                Text('Commit: Fix Login', style: AppTextStyles.body(theme.colorScheme.onSurface)),
                Text('Branch: main', style: AppTextStyles.body(theme.colorScheme.onSurface)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Logs', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                const SizedBox(height: 8),
                Text(
                  '> Running flutter build apk --release\n> Build succeeded in 3m 58s',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Artifacts', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                const Icon(Icons.download_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
