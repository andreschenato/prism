import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class ClickableLabel extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ClickableLabel({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          label,
          style: AppTextStyles.actionL.copyWith(color: AppColors.primaryMedium),
        ),
      ),
    );
  }
}
