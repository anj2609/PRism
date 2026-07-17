enum NotificationCategory { reviewRequest, mention, release, ci, issueUpdate, prUpdate }

class NotificationModel {
  final String id;
  final NotificationCategory category;
  final String title;
  final String subtitle;
  final DateTime receivedAt;
  final bool read;

  const NotificationModel({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.receivedAt,
    required this.read,
  });

  NotificationModel copyWith({bool? read}) {
    return NotificationModel(
      id: id,
      category: category,
      title: title,
      subtitle: subtitle,
      receivedAt: receivedAt,
      read: read ?? this.read,
    );
  }
}
