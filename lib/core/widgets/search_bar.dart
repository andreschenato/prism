import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SearchAnchor(
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 16),
            ),
            onTap: () {
              //controller.openView();
            },
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            leading: const Icon(Icons.search, color: AppColors.backgroundBlackDark),
            hintText: hintText,
          );      
        },
        suggestionsBuilder: (context, controller) {
          return List<ListTile>.generate(5, (index) {
            return ListTile(
              title: Text('Suggestion $index'),
              onTap: () {
                controller.text = 'Suggestion $index';
                controller.closeView(controller.text);
              },
            );
          });
        },
      ),
    );
  }
}
