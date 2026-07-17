import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/pull_request_model.dart';

final pullRequestListProvider = FutureProvider<List<PullRequestModel>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return const [
    PullRequestModel(
      number: 224,
      title: 'Add Google Login',
      author: 'John',
      state: PullRequestState.open,
      filesChanged: 15,
      additions: 240,
      deletions: 80,
      ciPassed: true,
      aiSummaryAvailable: true,
      requestedReview: true,
      assignedToMe: false,
    ),
    PullRequestModel(
      number: 218,
      title: 'Refactor Auth Module',
      author: 'Priya',
      state: PullRequestState.open,
      filesChanged: 8,
      additions: 120,
      deletions: 45,
      ciPassed: false,
      aiSummaryAvailable: true,
      requestedReview: false,
      assignedToMe: true,
    ),
  ];
});
