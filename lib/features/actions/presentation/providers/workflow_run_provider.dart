import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/workflow_run_model.dart';

final workflowRunListProvider = FutureProvider<List<WorkflowRunModel>>((ref) async {
  return const [
    WorkflowRunModel(id: 1, name: 'Android', status: WorkflowStatus.passed, branch: 'main', commitMessage: 'Fix Login', duration: Duration(minutes: 4)),
    WorkflowRunModel(id: 2, name: 'iOS', status: WorkflowStatus.failed, branch: 'main', commitMessage: 'Refactor Auth', duration: Duration(minutes: 6)),
    WorkflowRunModel(id: 3, name: 'Backend', status: WorkflowStatus.running, branch: 'develop', commitMessage: 'Remove Bugs', duration: Duration(minutes: 2)),
  ];
});
