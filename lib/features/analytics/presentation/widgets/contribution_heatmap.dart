import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ContributionHeatmap extends StatelessWidget {
  final List<int> weeklyContributions;

  const ContributionHeatmap({super.key, required this.weeklyContributions});

  Color _colorFor(int count) {
    if (count == 0) return AppColors.border;
    if (count < 3) return AppColors.primary.withValues(alpha: 0.3);
    if (count < 6) return AppColors.primary.withValues(alpha: 0.6);
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: weeklyContributions
          .map((count) => Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: _colorFor(count), borderRadius: BorderRadius.circular(4)),
              ))
          .toList(),
    );
  }
}
