import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => context.push('/settings')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(radius: 40, backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.white, size: 40)),
                const SizedBox(height: 12),
                Text('Anjali', style: AppTextStyles.heading2(theme.colorScheme.onSurface)),
                Text('@anj2609', style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ProfileStat(label: 'Followers', value: '128'),
              _ProfileStat(label: 'Following', value: '84'),
              _ProfileStat(label: 'Repositories', value: '18'),
              _ProfileStat(label: 'Stars', value: '340'),
            ],
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Organizations', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                const SizedBox(height: 8),
                Text('flutter-community, open-source-devs', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pinned Projects', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                const SizedBox(height: 8),
                Text('PRism, Flutter-App, DevTools-CLI', style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: AppTextStyles.heading3(theme.colorScheme.onSurface)),
        Text(label, style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
      ],
    );
  }
}
