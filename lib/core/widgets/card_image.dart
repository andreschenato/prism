import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CardImage extends StatelessWidget {
  final IconData iconPlaceholder;
  final String? imageUrl;
  const CardImage({super.key, required this.iconPlaceholder, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 150,
      decoration: const BoxDecoration(color: AppColors.primaryLightest),
      child: Center(
        child: Builder(
          builder: (context) {
            Image imageWidget = Image.network(
              imageUrl ?? '',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              width: double.infinity,
            );
            if (imageUrl != null) {
              return imageWidget;
            }
            return Icon(
              iconPlaceholder,
              color: AppColors.primaryDark,
              size: 60,
            );
          },
        ),
      ),
    );
  }
}
