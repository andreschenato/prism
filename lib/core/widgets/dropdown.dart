import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class Dropdown extends StatelessWidget {
  final Function(String?) onSelected;
  final List<DropdownMenuEntry<String>> entries;
  final double? width;
  final String label;
  final Widget? leadingIcon;

  const Dropdown({
    super.key,
    required this.onSelected,
    required this.entries,
    this.width,
    required this.label,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double menuWidth = constraints.maxWidth;

          const double maxMenuHeight = 250;
          const double itemHeight = 48;
          const double menuVerticalPadding = 16;

          final double calculatedContentHeight =
              (entries.length * itemHeight) + menuVerticalPadding;

          final double finalMenuHeight = min(
            calculatedContentHeight,
            maxMenuHeight,
          );

          return DropdownMenu<String>(
            width: menuWidth,
            leadingIcon: leadingIcon,
            enableFilter: true,
            hintText: label,
            dropdownMenuEntries: entries,
            trailingIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.backgroundBlackDark,
              size: 20,
            ),
            textStyle: AppTextStyles.actionM.copyWith(
              color: AppColors.backgroundBlackDark,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up_rounded,
              color: AppColors.backgroundBlackDark,
              size: 20,
            ),
            menuHeight: finalMenuHeight,
            menuStyle: MenuStyle(
              fixedSize: WidgetStatePropertyAll<Size>(
                Size(menuWidth, finalMenuHeight),
              ),
              backgroundColor: WidgetStatePropertyAll<Color>(
                AppColors.backgroundWhiteLight,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              hintStyle: AppTextStyles.actionM,
              fillColor: AppColors.backgroundWhiteLight,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
            ),
            onSelected: onSelected,
          );
        },
      ),
    );
  }
}
