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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  const SizedBox(height: 8),
                  _Header(username: 'Username', onEditTap: () {
                    // TODO: abrir modal/rota para editar foto/nome
                  }),
                  const SizedBox(height: 16),
                  NavigationTile(
                    label: 'Account',
                    onTap: () {
                      // TODO: push('/settings/account');
                    },
                  ),
                  NavigationTile(
                    label: 'Notifications',
                    onTap: () {
                      // TODO: push('/settings/notifications');
                    },
                  ),
                  NavigationTile(
                    label: 'Appearance',
                    onTap: () {
                      // TODO: push('/settings/appearance');
                    },
                  ),
                  NavigationTile(
                    label: 'Informations',
                    onTap: () {
                      // TODO: push('/settings/informations');
                    },
                  ),
                ],
              ),
            ),

            // botão sempre no rodapé
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _LogoutTile(
                label: 'Logout',
                onTap: () {
                  AuthApiSource().signOut();
                },
              ),
            ),
          ],
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

class _LogoutTile extends StatelessWidget{
  final String label;
  final VoidCallback onTap;
  const _LogoutTile({
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child:
        Material(
          color: AppColors.backgroundWhiteLight,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            iconColor: AppColors.errorDark,
            textColor: AppColors.errorDark,
            title: Text(label, style: AppTextStyles.actionL),
            trailing: const Icon(Icons.logout),
            onTap: onTap,
          ),
        )
    );
  }
}

