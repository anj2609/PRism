class AppConstants {
  AppConstants._();

  static const String appName = 'PRism';
  static const String githubApiBaseUrl = 'https://api.github.com';
  static const String githubGraphqlUrl = 'https://api.github.com/graphql';
  static const String githubOAuthAuthorizeUrl = 'https://github.com/login/oauth/authorize';
  static const String githubOAuthTokenUrl = 'https://github.com/login/oauth/access_token';

  static const String secureStorageTokenKey = 'github_access_token';
  static const String hiveRepositoriesBox = 'repositories_box';
  static const String hivePullRequestsBox = 'pull_requests_box';
  static const String hiveIssuesBox = 'issues_box';
  static const String hiveNotificationsBox = 'notifications_box';
  static const String hiveSettingsBox = 'settings_box';

  static const List<String> githubScopes = [
    'repo',
    'read:org',
    'notifications',
    'read:user',
  ];
}
