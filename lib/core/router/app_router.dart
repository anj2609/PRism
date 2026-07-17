import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/repositories/presentation/screens/repository_list_screen.dart';
import '../../features/repositories/presentation/screens/repository_detail_screen.dart';
import '../../features/pull_requests/presentation/screens/pull_request_list_screen.dart';
import '../../features/pull_requests/presentation/screens/pull_request_detail_screen.dart';
import '../../features/issues/presentation/screens/issues_kanban_screen.dart';
import '../../features/issues/presentation/screens/issue_detail_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/actions/presentation/screens/actions_screen.dart';
import '../../features/actions/presentation/screens/pipeline_detail_screen.dart';
import '../../features/releases/presentation/screens/releases_screen.dart';
import '../../features/search/presentation/screens/global_search_screen.dart';
import '../../features/ai_assistant/presentation/screens/ai_chat_screen.dart';
import '../../features/analytics/presentation/screens/analytics_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../shared/widgets/bottom_nav_scaffold.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(path: '/search', builder: (context, state) => const GlobalSearchScreen()),
    GoRoute(path: '/analytics', builder: (context, state) => const AnalyticsScreen()),
    GoRoute(
      path: '/pull-requests',
      builder: (context, state) => const PullRequestListScreen(),
      routes: [
        GoRoute(
          path: ':number',
          builder: (context, state) => PullRequestDetailScreen(
            pullRequestNumber: int.parse(state.pathParameters['number']!),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/issues',
      builder: (context, state) => const IssuesKanbanScreen(),
      routes: [
        GoRoute(
          path: ':number',
          builder: (context, state) => IssueDetailScreen(
            issueNumber: int.parse(state.pathParameters['number']!),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/actions',
      builder: (context, state) => const ActionsScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) => PipelineDetailScreen(
            workflowRunId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ],
    ),
    GoRoute(path: '/releases', builder: (context, state) => const ReleasesScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => BottomNavScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/repositories',
            builder: (context, state) => const RepositoryListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => RepositoryDetailScreen(
                  repositoryId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/ai-assistant', builder: (context, state) => const AiChatScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        ]),
      ],
    ),
  ],
);
