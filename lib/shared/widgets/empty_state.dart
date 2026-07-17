import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
          ],
        ],
      ),
    );
  }
}
