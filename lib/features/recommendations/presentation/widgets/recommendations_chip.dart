import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class RecommendationChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const RecommendationChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.secondaryDark
              : AppColors.backgroundWhiteMedium,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
