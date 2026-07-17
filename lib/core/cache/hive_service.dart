import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(AppConstants.hiveRepositoriesBox),
      Hive.openBox(AppConstants.hivePullRequestsBox),
      Hive.openBox(AppConstants.hiveIssuesBox),
      Hive.openBox(AppConstants.hiveNotificationsBox),
      Hive.openBox(AppConstants.hiveSettingsBox),
    ]);
  }

  static Box box(String name) => Hive.box(name);

  static Future<void> clearAll() async {
    await Hive.box(AppConstants.hiveRepositoriesBox).clear();
    await Hive.box(AppConstants.hivePullRequestsBox).clear();
    await Hive.box(AppConstants.hiveIssuesBox).clear();
    await Hive.box(AppConstants.hiveNotificationsBox).clear();
  }
}
