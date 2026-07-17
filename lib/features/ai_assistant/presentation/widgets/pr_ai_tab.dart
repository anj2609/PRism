import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class PrAiTab extends StatelessWidget {
  final int pullRequestNumber;

  const PrAiTab({super.key, required this.pullRequestNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader(title: 'Summary'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _BulletLine(text: 'Google Login added.'),
              _BulletLine(text: 'Firebase configured.'),
              _BulletLine(text: 'Login page updated.'),
              _BulletLine(text: 'Tests added.'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: 'Explain'),
        const SizedBox(height: 8),
        AppCard(
          child: Text(
            'Authentication flow now uses OAuth. Firebase exchanges token. User session is stored.',
            style: AppTextStyles.body(theme.colorScheme.onSurface),
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: 'Risks'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _BulletLine(text: 'Missing null handling', color: AppColors.danger),
              _BulletLine(text: 'Possible memory leak', color: AppColors.danger),
              _BulletLine(text: 'No loading state', color: AppColors.warning),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: 'Suggested Review Comments'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _SuggestionButton(label: 'Add Null Check'),
            _SuggestionButton(label: 'Extract Method'),
            _SuggestionButton(label: 'Improve Naming'),
            _SuggestionButton(label: 'Add Tests'),
          ],
        ),
      ],
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;
  final Color? color;

  const _BulletLine({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.circle, size: 6, color: color ?? theme.colorScheme.onSurface.withValues(alpha: 0.6)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTextStyles.body(theme.colorScheme.onSurface))),
        ],
      ),
    );
  }
}

class _SuggestionButton extends StatelessWidget {
  final String label;

  const _SuggestionButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Posted comment: $label')),
      ),
      icon: const Icon(Icons.auto_awesome, size: 16, color: AppColors.primary),
      label: Text(label),
    );
  }
}
