import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class GithubGraphqlClient {
  final FlutterSecureStorage secureStorage;

  GithubGraphqlClient({required this.secureStorage});

  Future<GraphQLClient> build() async {
    final token = await secureStorage.read(key: AppConstants.secureStorageTokenKey);
    final httpLink = HttpLink(
      AppConstants.githubGraphqlUrl,
      defaultHeaders: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }
}
