import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prism/core/theme/app_theme.dart';

class SocialLoginButton extends StatelessWidget {
  final String asset;
  final String label;
  final VoidCallback onPressed;
  final double? width;
  const SocialLoginButton({
    super.key,
    required this.asset,
    required this.label,
    required this.onPressed,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.actionM,
          backgroundColor: AppColors.backgroundWhiteLight,
          foregroundColor: AppColors.backgroundBlackDark,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            SvgPicture.asset(asset, width: 24, height: 24),
            Text(label, style: AppTextStyles.actionL),
          ],
        ),
      ),
    );
  }
}
