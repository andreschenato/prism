import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class NavigationTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? width;
  const NavigationTile({
    super.key,
    required this.label,
    required this.onTap,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
        child:
        Material(
          color: AppColors.backgroundWhiteLight,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            dense: true,
            title: Text(label, style: AppTextStyles.actionL),
            trailing: const Icon(Icons.chevron_right),
            onTap: onTap,
          ),
        )
    );
  }
}
