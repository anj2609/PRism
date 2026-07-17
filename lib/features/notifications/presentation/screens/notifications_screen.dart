import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_tile.dart';
import '../../domain/models/notification_model.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static const _groupOrder = [
    NotificationCategory.reviewRequest,
    NotificationCategory.mention,
    NotificationCategory.release,
    NotificationCategory.ci,
    NotificationCategory.issueUpdate,
    NotificationCategory.prUpdate,
  ];

  static const _groupLabels = {
    NotificationCategory.reviewRequest: 'Review Requests',
    NotificationCategory.mention: 'Mentions',
    NotificationCategory.release: 'Releases',
    NotificationCategory.ci: 'CI',
    NotificationCategory.issueUpdate: 'Issue Updates',
    NotificationCategory.prUpdate: 'PR Updates',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);
    final theme = Theme.of(context);

    if (notifications.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: const EmptyState(icon: Icons.notifications_off_outlined, title: 'No notifications'),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: [
          for (final category in _groupOrder)
            if (notifications.any((notification) => notification.category == category)) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(_groupLabels[category]!, style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
              ),
              for (final notification in notifications.where((notification) => notification.category == category))
                NotificationTile(
                  notification: notification,
                  onDismissRead: () => ref.read(notificationProvider.notifier).markRead(notification.id),
                  onDismissArchive: () => ref.read(notificationProvider.notifier).archive(notification.id),
                ),
            ],
        ],
      ),
    );
  }
}
