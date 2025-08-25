import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        margin: EdgeInsetsGeometry.all(0),
        shadowColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        color: AppColors.backgroundWhiteLight,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.backgroundWhiteMedium,
                  child: Icon(icon, color: AppColors.primaryDark, size: 24),
                ),
                Text(label, style: AppTextStyles.actionM),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
