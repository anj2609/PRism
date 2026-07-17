import 'package:dio/dio.dart';
import '../../domain/models/pull_request_model.dart';

class PullRequestRepository {
  final Dio dio;

  PullRequestRepository({required this.dio});

  Future<List<PullRequestModel>> fetchPullRequests({required String owner, required String repo}) async {
    final response = await dio.get('/repos/$owner/$repo/pulls');
    final data = response.data as List;
    return data.map((json) {
      final map = json as Map<String, dynamic>;
      return PullRequestModel(
        number: map['number'] as int,
        title: map['title'] as String,
        author: (map['user'] as Map<String, dynamic>?)?['login'] as String? ?? 'unknown',
        state: PullRequestState.open,
        filesChanged: map['changed_files'] as int? ?? 0,
        additions: map['additions'] as int? ?? 0,
        deletions: map['deletions'] as int? ?? 0,
        ciPassed: true,
        aiSummaryAvailable: true,
        requestedReview: false,
        assignedToMe: false,
      );
    }).toList();
  }
}
