import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/release_provider.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';

class ReleasesScreen extends ConsumerWidget {
  const ReleasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final releasesAsync = ref.watch(releaseListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Releases')),
      body: releasesAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => Center(child: Text('$error')),
        data: (releases) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: releases.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final release = releases[index];
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(release.version, style: AppTextStyles.heading3(theme.colorScheme.onSurface)),
                      Text(AppDateUtils.formatFull(release.date), style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.5))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(release.notes, style: AppTextStyles.body(theme.colorScheme.onSurface.withValues(alpha: 0.7))),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: release.assets
                        .map((asset) => Chip(
                              avatar: const Icon(Icons.download_outlined, size: 16),
                              label: Text(asset),
                            ))
                        .toList(),
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
