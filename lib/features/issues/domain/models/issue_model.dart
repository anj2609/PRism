enum IssueColumn { open, inProgress, closed }

enum IssuePriority { low, medium, high }

class IssueModel {
  final int number;
  final String title;
  final IssuePriority priority;
  final IssueColumn column;
  final bool assigned;
  final String label;
  final DateTime createdAt;

  const IssueModel({
    required this.number,
    required this.title,
    required this.priority,
    required this.column,
    required this.assigned,
    required this.label,
    required this.createdAt,
  });
}
