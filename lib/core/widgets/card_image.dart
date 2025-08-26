import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardImage extends StatelessWidget {
  final IconData iconPlaceholder;
  final String? imageUrl;
  const CardImage({super.key, required this.iconPlaceholder, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final placeholder = Ink(
      decoration: const BoxDecoration(color: AppColors.primaryLightest),
      child: Center(
        child: Icon(iconPlaceholder, color: AppColors.primaryDark, size: 60),
      ),
    );

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, imageProvider) => Ink.image(
          alignment: Alignment.topCenter,
          image: imageProvider,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      );
    }

    return placeholder;
  }
}
