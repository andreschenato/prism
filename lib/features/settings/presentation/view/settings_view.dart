// lib/features/user/presentation/user_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/button.dart';
import '../../../../core/widgets/navigation_tile.dart';
import '../../../auth/data/sources/auth_api_source.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: AppBar(), body: _buildBody(context, ref));
  }


  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  spacing: 10,
                  children: [
                    _Header(username: 'Username', onEditTap: () {
                      // TODO: abrir modal/rota para editar foto/nome
                    }),
                    NavigationTile(
                      label: 'Account',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/account');
                      },
                    ),
                    NavigationTile(
                      label: 'Notifications',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/notifications');
                      },
                    ),
                    NavigationTile(
                      label: 'Appearance',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/appearance');
                      },
                    ),
                    NavigationTile(
                      label: 'Informations',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/informations');
                      },
                    ),
                  ],
                ),
              ),

               NavigationTile(
                  label: 'Logout',
                  color: AppColors.errorDark,
                  icon: Icon(Icons.logout),
                  onTap: () {
                    AuthApiSource().signOut();
                  },
                ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.username,
    this.onEditTap,
  });

  final String username;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primaryDark, // azul semelhante ao mock
              child: Icon(Icons.person, color: Colors.white, size: 48),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 1,
                child: InkWell(
                  onTap: onEditTap,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.edit, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          username,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}


