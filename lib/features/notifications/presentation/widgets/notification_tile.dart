import 'package:flutter/material.dart';
import '../../domain/models/notification_model.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDismissRead;
  final VoidCallback onDismissArchive;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onDismissRead,
    required this.onDismissArchive,
  });

  IconData get _icon {
    switch (notification.category) {
      case NotificationCategory.reviewRequest:
        return Icons.rate_review_outlined;
      case NotificationCategory.mention:
        return Icons.alternate_email;
      case NotificationCategory.release:
        return Icons.rocket_launch_outlined;
      case NotificationCategory.ci:
        return Icons.build_outlined;
      case NotificationCategory.issueUpdate:
        return Icons.bug_report_outlined;
      case NotificationCategory.prUpdate:
        return Icons.merge_type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(notification.id),
      background: Container(color: AppColors.info, alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 20), child: const Icon(Icons.done, color: Colors.white)),
      secondaryBackground: Container(color: AppColors.textSecondaryLight, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.archive_outlined, color: Colors.white)),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onDismissRead();
        } else {
          onDismissArchive();
        }
        return true;
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.12),
          child: Icon(_icon, color: AppColors.primary, size: 20),
        ),
        title: Text(notification.title, style: notification.read ? AppTextStyles.body(theme.colorScheme.onSurface) : AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
        subtitle: Text(notification.subtitle, style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.6))),
        trailing: Text(AppDateUtils.timeAgo(notification.receivedAt), style: AppTextStyles.caption(theme.colorScheme.onSurface.withValues(alpha: 0.5))),
      ),
    );
  }
}
