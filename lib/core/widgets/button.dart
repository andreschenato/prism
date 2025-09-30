import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final IconData? iconData; 

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: AppTextStyles.actionM,
      backgroundColor: AppColors.primaryMedium,
      foregroundColor: AppColors.backgroundWhiteLight,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );

    Widget buttonContent;

    if (iconData != null) {
      buttonContent = ElevatedButton.icon(
        onPressed: onPressed,
        style: buttonStyle,
        icon: Icon(iconData, size: AppTextStyles.actionL.fontSize), 
        label: Text(label, style: AppTextStyles.actionM), 
      );
    } else {
      buttonContent = ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(label, style: AppTextStyles.actionM),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      child: buttonContent,
    );
  }
}