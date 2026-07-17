import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/pull_request_provider.dart';
import '../widgets/pull_request_card.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/empty_state.dart';

class PullRequestListScreen extends ConsumerStatefulWidget {
  const PullRequestListScreen({super.key});

  @override
  ConsumerState<PullRequestListScreen> createState() => _PullRequestListScreenState();
}

class _PullRequestListScreenState extends ConsumerState<PullRequestListScreen> {
  String _filter = 'Open';
  final List<String> _filters = const ['Open', 'Closed', 'Merged', 'Assigned to Me', 'Requested Review'];

  @override
  Widget build(BuildContext context) {
    final pullRequestsAsync = ref.watch(pullRequestListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pull Requests')),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final selected = filter == _filter;
                return ChoiceChip(
                  label: Text(filter),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = filter),
                );
              },
            ),
          ),
          Expanded(
            child: pullRequestsAsync.when(
              loading: () => const LoadingIndicator(),
              error: (error, _) => Center(child: Text('$error')),
              data: (pullRequests) {
                if (pullRequests.isEmpty) {
                  return const EmptyState(icon: Icons.merge_type, title: 'No pull requests found');
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: pullRequests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final pullRequest = pullRequests[index];
                    return PullRequestCard(
                      pullRequest: pullRequest,
                      onTap: () => context.push('/pull-requests/${pullRequest.number}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
