import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final String label;
  const CustomSearchBar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: label,
          hintStyle: AppTextStyles.bodyL.copyWith(
            color: AppColors.backgroundBlackDark,
          ),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.backgroundWhiteLight,
        ),
      ),
    );
  }
}
