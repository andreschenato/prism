import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final bool reverseColors;
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.reverseColors = false,
  });
  @override
  Widget build(BuildContext context) {
    var primary = reverseColors
        ? AppColors.backgroundWhiteLight
        : AppColors.primaryMedium;
    var secondary = reverseColors
        ? AppColors.primaryMedium
        : AppColors.backgroundWhiteLight;
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.actionM,
          backgroundColor: primary,
          foregroundColor: secondary,
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
