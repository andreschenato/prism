import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final String? label;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24.0,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color ?? AppColors.backgroundBlackDark),
          onPressed: onPressed,
          tooltip: 'Icon Button',
          iconSize: size,
        ),
        Visibility(
          visible: label != null && label!.isNotEmpty,
          child: Text(label ?? '', style: AppTextStyles.bodyM)
          ),
      ],
    );
  }
}
