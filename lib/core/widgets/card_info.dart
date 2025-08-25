import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CardInfo extends StatelessWidget {
  final String label;
  final String? subTitle;
  const CardInfo({super.key, required this.label, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.backgroundWhiteLight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          spacing: subTitle != null ? 5 : 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              textAlign: TextAlign.left,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyS.copyWith(
                color: AppColors.backgroundBlackDark,
              ),
            ),
            Visibility(
              visible: subTitle != null,
              child: Text(
                subTitle ?? '',
                textAlign: TextAlign.left,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyXS.copyWith(
                  color: AppColors.backgroundBlackDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
