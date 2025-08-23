import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class Menu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const Menu({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.backgroundWhiteLight,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.primaryLight,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
