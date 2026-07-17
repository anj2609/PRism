class ReleaseModel {
  final String version;
  final DateTime date;
  final String notes;
  final List<String> assets;

  const ReleaseModel({
    required this.version,
    required this.date,
    required this.notes,
    required this.assets,
  });
}
