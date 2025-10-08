import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class RoundedMiniCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  const RoundedMiniCard({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 5),
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.bodyS.copyWith(
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
