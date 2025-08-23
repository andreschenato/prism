import 'package:flutter/material.dart';
import 'package:prism/core/widgets/card_image.dart';
import 'package:prism/core/widgets/card_info.dart';

class MediaCard extends StatelessWidget {
  final String label;
  final String? subTitle;
  final IconData iconPlaceholder;
  final String? imageUrl;
  final VoidCallback onPressed;
  final bool? displayLabel;
  const MediaCard({
    super.key,
    required this.label,
    this.subTitle,
    required this.onPressed,
    required this.iconPlaceholder,
    this.imageUrl,
    this.displayLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      clipBehavior: Clip.antiAlias,
      height: 180,
      width: 120,
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              Expanded(
                child: CardImage(
                  iconPlaceholder: iconPlaceholder,
                  imageUrl: imageUrl,
                ),
              ),
              Visibility(
                visible: displayLabel!,
                child: CardInfo(
                  label: label,
                  subTitle: subTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
