import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/issue_model.dart';

final issueListProvider = FutureProvider<List<IssueModel>>((ref) async {
  final now = DateTime.now();
  return [
    IssueModel(
      number: 301,
      title: 'Crash on Login',
      priority: IssuePriority.high,
      column: IssueColumn.open,
      assigned: true,
      label: 'Bug',
      createdAt: now.subtract(const Duration(days: 1)),
    ),
    IssueModel(
      number: 298,
      title: 'Dark mode contrast issue',
      priority: IssuePriority.medium,
      column: IssueColumn.inProgress,
      assigned: false,
      label: 'UI',
      createdAt: now.subtract(const Duration(days: 3)),
    ),
    IssueModel(
      number: 290,
      title: 'Update dependency versions',
      priority: IssuePriority.low,
      column: IssueColumn.closed,
      assigned: false,
      label: 'Chore',
      createdAt: now.subtract(const Duration(days: 6)),
    ),
  ];
});
