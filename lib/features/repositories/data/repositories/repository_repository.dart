import 'package:dio/dio.dart';
import '../../domain/models/repository_model.dart';

class RepositoryRepository {
  final Dio dio;

  RepositoryRepository({required this.dio});

  Future<List<RepositoryModel>> fetchUserRepositories() async {
    final response = await dio.get('/user/repos', queryParameters: {'sort': 'updated'});
    final data = response.data as List;
    return data.map((json) => RepositoryModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
