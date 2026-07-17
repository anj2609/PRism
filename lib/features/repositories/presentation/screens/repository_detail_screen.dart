import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../core/theme/app_text_styles.dart';

class RepositoryDetailScreen extends StatelessWidget {
  final String repositoryId;

  const RepositoryDetailScreen({super.key, required this.repositoryId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Repository #$repositoryId'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Branches'),
              Tab(text: 'Commits'),
              Tab(text: 'Issues'),
              Tab(text: 'PRs'),
              Tab(text: 'Actions'),
              Tab(text: 'Releases'),
              Tab(text: 'Contributors'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _OverviewTab(),
            const Center(child: Text('Branches')),
            const Center(child: Text('Commits')),
            const Center(child: Text('Issues')),
            const Center(child: Text('Pull Requests')),
            const Center(child: Text('Actions')),
            const Center(child: Text('Releases')),
            const Center(child: Text('Contributors')),
          ],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
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
              Text('README', style: AppTextStyles.heading3(theme.colorScheme.onSurface)),
              const SizedBox(height: 8),
              Text(
                'This repository does not have a description yet.',
                style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(label: 'Language', value: 'Dart'),
              _InfoRow(label: 'Stars', value: '340'),
              _InfoRow(label: 'Forks', value: '52'),
              _InfoRow(label: 'License', value: 'MIT'),
              _InfoRow(label: 'Latest Commit', value: 'Fix login bug'),
              _InfoRow(label: 'Open Issues', value: '8'),
              _InfoRow(label: 'Latest Release', value: 'v2.1.0'),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          Text(value, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
        ],
      ),
    );
  }
}
