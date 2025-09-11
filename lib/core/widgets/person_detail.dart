import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class PersonDetail extends StatelessWidget {
  final IconData icon;
  final List<String> persons;
  const PersonDetail({super.key, required this.persons, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.backgroundBlackDark,),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.bodyXS.copyWith(
                color: AppColors.backgroundBlackDark,
              ),
              children: persons.map((name) {
                final isLast = persons.last == name;
                return TextSpan(text: isLast ? name : '$name, ');
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
