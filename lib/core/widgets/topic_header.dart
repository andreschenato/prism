import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class TopicHeader extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const TopicHeader({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.h3),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'See more',
              style: AppTextStyles.actionL.copyWith(
                color: AppColors.primaryMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
