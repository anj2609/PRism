import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DiffLine {
  final String content;
  final int? oldLineNumber;
  final int? newLineNumber;
  final DiffLineType type;

  const DiffLine({required this.content, this.oldLineNumber, this.newLineNumber, required this.type});
}

enum DiffLineType { context, addition, deletion }

class DiffViewer extends StatelessWidget {
  final String fileName;
  final List<DiffLine> lines;

  const DiffViewer({super.key, required this.fileName, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.black87,
          child: Text(fileName, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 13)),
        ),
        ...lines.map((line) => _DiffLineRow(line: line)),
      ],
    );
  }
}

class _DiffLineRow extends StatelessWidget {
  final DiffLine line;

  const _DiffLineRow({required this.line});

  Color get _backgroundColor {
    switch (line.type) {
      case DiffLineType.addition:
        return AppColors.success.withValues(alpha: 0.12);
      case DiffLineType.deletion:
        return AppColors.danger.withValues(alpha: 0.12);
      case DiffLineType.context:
        return Colors.transparent;
    }
  }

  String get _prefix {
    switch (line.type) {
      case DiffLineType.addition:
        return '+';
      case DiffLineType.deletion:
        return '-';
      case DiffLineType.context:
        return ' ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text('${line.oldLineNumber ?? ''}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.grey))),
          SizedBox(width: 32, child: Text('${line.newLineNumber ?? ''}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.grey))),
          Text('$_prefix ', style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
          Expanded(child: Text(line.content, style: const TextStyle(fontFamily: 'monospace', fontSize: 13))),
        ],
      ),
    );
  }
}
