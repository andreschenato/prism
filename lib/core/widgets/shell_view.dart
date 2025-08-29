import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/menu.dart';

class ShellView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: navigationShell,
      bottomNavigationBar: Menu(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
