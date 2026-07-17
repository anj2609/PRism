enum PullRequestState { open, closed, merged }

class PullRequestModel {
  final int number;
  final String title;
  final String author;
  final PullRequestState state;
  final int filesChanged;
  final int additions;
  final int deletions;
  final bool ciPassed;
  final bool aiSummaryAvailable;
  final bool requestedReview;
  final bool assignedToMe;

  const PullRequestModel({
    required this.number,
    required this.title,
    required this.author,
    required this.state,
    required this.filesChanged,
    required this.additions,
    required this.deletions,
    required this.ciPassed,
    required this.aiSummaryAvailable,
    required this.requestedReview,
    required this.assignedToMe,
  });
}
