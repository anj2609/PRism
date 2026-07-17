import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/repository_repository.dart';
import '../../domain/models/repository_model.dart';
import '../../../../core/di/providers.dart';

final repositoryRepositoryProvider = Provider<RepositoryRepository>((ref) {
  return RepositoryRepository(dio: ref.watch(dioClientProvider));
});

final repositoryListProvider = FutureProvider<List<RepositoryModel>>((ref) async {
  return ref.watch(repositoryRepositoryProvider).fetchUserRepositories();
});
