import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomFormLabel extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  final bool isError;

  const CustomFormLabel({
    super.key,
    required this.label,
    this.textAlign = TextAlign.start,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: label,
          hintStyle: AppTextStyles.bodyM.copyWith(
            color: isError
                ? AppColors.errorDark
                : AppColors.backgroundBlackDark,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: isError
              ? AppColors.errorLight
              : AppColors.backgroundWhiteLight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        style: AppTextStyles.bodyM, // Define o estilo do texto digitado
      ),
    );
  }
}
