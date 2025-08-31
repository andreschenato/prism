import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class MiniCard extends StatelessWidget {
  final String text;
  const MiniCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteLight,
        border: Border.all(color: AppColors.backgroundBlackMedium),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          text,
          style: AppTextStyles.bodyXS.copyWith(
            color: AppColors.backgroundBlackMedium,
          ),
        ),
      ),
    );
  }
}
