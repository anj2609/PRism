class RepositoryModel {
  final String id;
  final String name;
  final String owner;
  final bool isPrivate;
  final int stars;
  final int forks;
  final int openPrCount;
  final int openIssueCount;
  final String language;
  final String license;
  final DateTime updatedAt;

  const RepositoryModel({
    required this.id,
    required this.name,
    required this.owner,
    required this.isPrivate,
    required this.stars,
    required this.forks,
    required this.openPrCount,
    required this.openIssueCount,
    required this.language,
    required this.license,
    required this.updatedAt,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      owner: json['owner'] as String,
      isPrivate: json['private'] as bool? ?? false,
      stars: json['stargazers_count'] as int? ?? 0,
      forks: json['forks_count'] as int? ?? 0,
      openPrCount: json['open_pr_count'] as int? ?? 0,
      openIssueCount: json['open_issues_count'] as int? ?? 0,
      language: json['language'] as String? ?? 'Unknown',
      license: json['license'] as String? ?? 'None',
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
