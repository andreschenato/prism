import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class EditableCard extends StatelessWidget {
  const EditableCard({
    super.key,
    required this.value,
    required this.onTap,
    this.obscureLikeMock = false,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    this.trailing,
    this.textStyle,
  });

  final String value;
  final VoidCallback onTap;
  final bool obscureLikeMock;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget? trailing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = backgroundColor ?? AppColors.backgroundBlackLight;
    final resolvedTextStyle = (textStyle ?? const TextStyle()).copyWith(
      color: textStyle?.color ?? AppColors.backgroundBlackMedium,
      letterSpacing: obscureLikeMock ? 2 : 0,
    );

    return Material(
      color: resolvedColor,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: resolvedTextStyle,
                ),
              ),
              trailing ?? const Icon(Icons.edit, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
