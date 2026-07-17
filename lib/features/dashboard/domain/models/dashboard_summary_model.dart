class DashboardSummary {
  final int repositoryCount;
  final int openPrReviews;
  final int assignedIssues;
  final int failedBuilds;
  final int unreadNotifications;
  final int contributionStreak;

  const DashboardSummary({
    required this.repositoryCount,
    required this.openPrReviews,
    required this.assignedIssues,
    required this.failedBuilds,
    required this.unreadNotifications,
    required this.contributionStreak,
  });

  factory DashboardSummary.empty() => const DashboardSummary(
        repositoryCount: 0,
        openPrReviews: 0,
        assignedIssues: 0,
        failedBuilds: 0,
        unreadNotifications: 0,
        contributionStreak: 0,
      );
}
