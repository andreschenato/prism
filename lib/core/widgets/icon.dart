import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class StarIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const StarIcon({
    super.key,
    this.icon = Icons.star,
    this.backgroundColor = AppColors.backgroundWhiteMedium,
    this.iconColor = AppColors.primaryDark,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: size, // controla o círculo
        child: Icon(
          icon,
          color: iconColor,
          size: size, // controla o ícone
        ),
      ),
    );
  }
}
