import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CardImage extends StatelessWidget {
  final IconData iconPlaceholder;
  final String? imageUrl;
  const CardImage({super.key, required this.iconPlaceholder, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Ink.image(
        alignment: Alignment.topCenter,
        image: NetworkImage(imageUrl!),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Ink(
      decoration: const BoxDecoration(color: AppColors.primaryLightest),
      child: Center(
        child: Icon(iconPlaceholder, color: AppColors.primaryDark, size: 60),
      ),
    );
  }
}
