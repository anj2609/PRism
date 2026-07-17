import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/dio_client.dart';
import '../network/github_graphql_client.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final dioClientProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return DioClient(secureStorage: secureStorage).dio;
});

final githubGraphqlClientProvider = Provider<GithubGraphqlClient>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return GithubGraphqlClient(secureStorage: secureStorage);
});
