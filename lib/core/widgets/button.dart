import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.actionM,
          backgroundColor: AppColors.primaryMedium,
          foregroundColor: AppColors.backgroundWhiteLight,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        child: Text(label, style: AppTextStyles.actionM),
      ),
    );
  }
}
