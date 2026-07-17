import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/repository_provider.dart';
import '../widgets/repository_card.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/empty_state.dart';

class RepositoryListScreen extends ConsumerStatefulWidget {
  const RepositoryListScreen({super.key});

  @override
  ConsumerState<RepositoryListScreen> createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends ConsumerState<RepositoryListScreen> {
  String _filter = 'All';
  final List<String> _filters = const ['All', 'Private', 'Public', 'Starred', 'Recently Updated'];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final repositoriesAsync = ref.watch(repositoryListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Repositories')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search repositories',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 8),
          Expanded(
            child: repositoriesAsync.when(
              loading: () => const LoadingIndicator(),
              error: (error, _) => Center(child: Text('$error')),
              data: (repositories) {
                if (repositories.isEmpty) {
                  return const EmptyState(icon: Icons.folder_off_outlined, title: 'No repositories found');
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: repositories.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final repository = repositories[index];
                    return RepositoryCard(
                      repository: repository,
                      onTap: () => context.push('/repositories/${repository.id}'),
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
