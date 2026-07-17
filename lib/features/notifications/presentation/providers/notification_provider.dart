import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/notification_model.dart';

class NotificationNotifier extends StateNotifier<List<NotificationModel>> {
  NotificationNotifier() : super(_seed());

  static List<NotificationModel> _seed() {
    final now = DateTime.now();
    return [
      NotificationModel(id: '1', category: NotificationCategory.reviewRequest, title: 'Review requested', subtitle: 'John requested your review on #224', receivedAt: now.subtract(const Duration(minutes: 20)), read: false),
      NotificationModel(id: '2', category: NotificationCategory.ci, title: 'Build failed', subtitle: 'Android build failed on main', receivedAt: now.subtract(const Duration(hours: 1)), read: false),
      NotificationModel(id: '3', category: NotificationCategory.release, title: 'New release', subtitle: 'Flutter v2.1 has been published', receivedAt: now.subtract(const Duration(hours: 3)), read: true),
    ];
  }

  void markRead(String id) {
    state = [
      for (final notification in state)
        if (notification.id == id) notification.copyWith(read: true) else notification,
    ];
  }

  void archive(String id) {
    state = state.where((notification) => notification.id != id).toList();
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<NotificationModel>>((ref) {
  return NotificationNotifier();
});
