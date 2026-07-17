import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/release_model.dart';

final releaseListProvider = FutureProvider<List<ReleaseModel>>((ref) async {
  return [
    ReleaseModel(
      version: 'v2.1.0',
      date: DateTime.now().subtract(const Duration(days: 2)),
      notes: 'Added Google login, fixed crash on startup, improved dark mode contrast.',
      assets: const ['app-release.apk', 'app-release.ipa'],
    ),
    ReleaseModel(
      version: 'v2.0.0',
      date: DateTime.now().subtract(const Duration(days: 30)),
      notes: 'Major redesign of the dashboard and repository browser.',
      assets: const ['app-release.apk'],
    ),
  ];
});
