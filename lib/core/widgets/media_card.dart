import 'package:flutter/material.dart';
import 'package:prism/core/widgets/card_image.dart';
import 'package:prism/core/widgets/card_info.dart';

class MediaCard extends StatelessWidget {
  final String label;
  final String? subTitle;
  final IconData iconPlaceholder;
  final String? imageUrl;
  final VoidCallback onPressed;
  const MediaCard({
    super.key,
    required this.label,
    this.subTitle,
    required this.onPressed,
    required this.iconPlaceholder,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 120,
          child: Material(
            child: InkWell(
              onTap: onPressed,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardImage(
                    iconPlaceholder: iconPlaceholder,
                    imageUrl: imageUrl,
                  ),
                  CardInfo(label: label, subTitle: subTitle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
