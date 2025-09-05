import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool hideInput;
  const TextInput({super.key, required this.label, required this.controller, this.hideInput = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hideInput,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        fillColor: AppColors.backgroundWhiteMedium,
        filled: true,
        labelStyle: AppTextStyles.bodyM.copyWith(
          color: AppColors.backgroundBlackDark,
        ),
        labelText: label,
      ),
    );
  }
}
