import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/horizontal_scroll_list.dart';

class HorizontalScrollSection extends StatelessWidget {
  final String title;
  final List components;
  const HorizontalScrollSection({
    super.key,
    required this.title,
    required this.components,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text(title, style: AppTextStyles.h3),
        HorizontalScrollList(components: components),
      ],
    );
  }
}
