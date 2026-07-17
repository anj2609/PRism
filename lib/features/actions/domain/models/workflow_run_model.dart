enum WorkflowStatus { passed, failed, running }

class WorkflowRunModel {
  final int id;
  final String name;
  final WorkflowStatus status;
  final String branch;
  final String commitMessage;
  final Duration duration;

  const WorkflowRunModel({
    required this.id,
    required this.name,
    required this.status,
    required this.branch,
    required this.commitMessage,
    required this.duration,
  });
}
