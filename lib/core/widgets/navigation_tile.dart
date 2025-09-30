import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class NavigationTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? width;
  final Icon icon;
  final Color color;
  const NavigationTile({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
    required this.icon,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: Material(
        color: AppColors.backgroundWhiteLight,
        child: ListTile(
          textColor: color,
          iconColor: color,
          dense: true,
          title: Text(label, style: AppTextStyles.actionL),
          trailing: icon,
          onTap: onTap,
        ),
      ),
    );
  }
}
